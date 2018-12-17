/*
 *  Copyright (c) 2018 AITIA International Inc.
 *
 *  This work is part of the Productive 4.0 innovation project, which receives grants from the
 *  European Commissions H2020 research and innovation programme, ECSEL Joint Undertaking
 *  (project no. 737459), the free state of Saxony, the German Federal Ministry of Education and
 *  national funding authorities from involved countries.
 */

package eu.arrowhead.common.database;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import eu.arrowhead.common.exception.BadPayloadException;
import eu.arrowhead.common.messages.ArrowheadBase;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapKeyColumn;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import org.hibernate.annotations.Check;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.Type;

/**
 * JPA entity class for storing <tt>OrchestrationStore</tt> information in the database. The <i>arrowhead_service_id</i>, <i>consumer_system_id</i>,
 * <i>priority</i> and <i>is_default</i> columns must be unique together. The <i>priority</i> integer can not be negative. <p> The class implements
 * the <tt>Comparable</tt> interface based on the priority field (but does not override the equals() method).
 *
 * @author Umlauf Zoltán
 */
@Entity
@JsonIgnoreProperties({"alwaysMandatoryFields"})
@Table(name = "orchestration_store", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"arrowhead_service_id", "consumer_system_id", "priority", "is_default"})})
@Check(constraints = "priority >= 1 AND (provider_cloud_id IS NULL OR is_default = false)")
public class OrchestrationStore extends ArrowheadBase implements Comparable<OrchestrationStore> {

  @Transient
  private static final Set<String> alwaysMandatoryFields = new HashSet<>(
      Arrays.asList("service", "consumer", "providerSystem", "priority", "defaultEntry"));

  @Column(name = "id")
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private int id;

  @JoinColumn(name = "arrowhead_service_id")
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
  private ArrowheadService service;

  @JoinColumn(name = "consumer_system_id")
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
  private ArrowheadSystem consumer;

  @JoinColumn(name = "provider_system_id")
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
  private ArrowheadSystem providerSystem;

  @JoinColumn(name = "provider_cloud_id")
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
  private ArrowheadCloud providerCloud;

  @Column(name = "priority")
  private Integer priority;

  @Column(name = "is_default")
  @Type(type = "yes_no")
  private boolean defaultEntry;

  @Column(name = "name")
  private String name;

  @Column(name = "last_updated")
  private LocalDateTime lastUpdated;

  @Column(name = "instruction")
  private String instruction;

  @JsonInclude(Include.NON_EMPTY)
  @ElementCollection(fetch = FetchType.LAZY)
  @LazyCollection(LazyCollectionOption.FALSE)
  @MapKeyColumn(name = "attribute_key")
  @Column(name = "attribute_value", length = 2047)
  @CollectionTable(name = "orchestration_store_attributes", joinColumns = @JoinColumn(name = "store_entry_id"))
  private Map<String, String> attributes = new HashMap<>();

  //Only to convert ServiceRegistryEntries to Store entries without data loss
  @Transient
  private String serviceURI;

  public OrchestrationStore() {
  }

  public OrchestrationStore(ArrowheadService service, ArrowheadSystem consumer, ArrowheadSystem providerSystem, ArrowheadCloud providerCloud,
                            int priority) {
    this.service = service;
    this.consumer = consumer;
    this.providerSystem = providerSystem;
    this.providerCloud = providerCloud;
    this.priority = priority;
  }

  public OrchestrationStore(ArrowheadService service, ArrowheadSystem consumer, ArrowheadSystem providerSystem, ArrowheadCloud providerCloud,
                            Integer priority, boolean defaultEntry, String name, LocalDateTime lastUpdated, String instruction,
                            Map<String, String> attributes, String serviceURI) {
    this.service = service;
    this.consumer = consumer;
    this.providerSystem = providerSystem;
    this.providerCloud = providerCloud;
    this.priority = priority;
    this.defaultEntry = defaultEntry;
    this.name = name;
    this.lastUpdated = lastUpdated;
    this.instruction = instruction;
    this.attributes = attributes;
    this.serviceURI = serviceURI;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public ArrowheadService getService() {
    return service;
  }

  public void setService(ArrowheadService service) {
    this.service = service;
  }

  public ArrowheadSystem getConsumer() {
    return consumer;
  }

  public void setConsumer(ArrowheadSystem consumer) {
    this.consumer = consumer;
  }

  public ArrowheadSystem getProviderSystem() {
    return providerSystem;
  }

  public void setProviderSystem(ArrowheadSystem providerSystem) {
    this.providerSystem = providerSystem;
  }

  public ArrowheadCloud getProviderCloud() {
    return providerCloud;
  }

  public void setProviderCloud(ArrowheadCloud providerCloud) {
    this.providerCloud = providerCloud;
  }

  public Integer getPriority() {
    return priority;
  }

  public void setPriority(Integer priority) {
    this.priority = priority;
  }

  public boolean isDefaultEntry() {
    return defaultEntry;
  }

  public void setDefaultEntry(boolean defaultEntry) {
    this.defaultEntry = defaultEntry;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public LocalDateTime getLastUpdated() {
    return lastUpdated;
  }

  public void setLastUpdated(LocalDateTime lastUpdated) {
    this.lastUpdated = lastUpdated;
  }

  public String getInstruction() {
    return instruction;
  }

  public void setInstruction(String instruction) {
    this.instruction = instruction;
  }

  public Map<String, String> getAttributes() {
    return attributes;
  }

  public void setAttributes(Map<String, String> attributes) {
    this.attributes = attributes;
  }

  public String getServiceURI() {
    return serviceURI;
  }

  public void setServiceURI(String serviceURI) {
    this.serviceURI = serviceURI;
  }

  public Set<String> missingFields(boolean throwException, Set<String> mandatoryFields) {
    Set<String> mf = new HashSet<>(alwaysMandatoryFields);
    if (mandatoryFields != null) {
      mf.addAll(mandatoryFields);
    }
    Set<String> nonNullFields = getFieldNamesWithNonNullValue();
    mf.removeAll(nonNullFields);
    if (service != null) {
      mf = service.missingFields(false, false, mf);
    }

    Set<String> fromConsumer = new HashSet<>();
    Set<String> fromProvider = new HashSet<>();
    if (consumer != null) {
      fromConsumer = consumer.missingFields(false, mf);
    }
    if (providerSystem != null) {
      fromProvider = providerSystem.missingFields(false, mf);
    }
    mf = new HashSet<>(fromConsumer);
    mf.addAll(fromProvider);

    if (priority < 0) {
      mf.add("Priority can not be negative!");
    }

    if (providerCloud != null) {
      if (defaultEntry) {
        mf.add("Default store entries can only have intra-cloud providers!");
      } else {
        Set<String> fromCloud = providerCloud.missingFields(false, new HashSet<>(Arrays.asList("ArrowheadCloud:address", "gatekeeperServiceURI")));
        mf.addAll(fromCloud);
      }
    }

    if (throwException && !mf.isEmpty()) {
      throw new BadPayloadException("Missing mandatory fields for " + getClass().getSimpleName() + ": " + String.join(", ", mf));
    }
    return mf;
  }

  /**
   * Note: This class has a natural ordering that is inconsistent with equals(). <p> The field <i>priority</i> is used to sort instances of this class
   * in a collection. Priority is non-negative. If this.priority < other.priority that means <i>this</i> is more ahead in a collection than
   * <i>other</i> and therefore has a higher priority. This means priority = 0 is the highest priority for a Store entry.
   */
  @Override
  public int compareTo(OrchestrationStore other) {
    return this.priority - other.priority;
  }

}
