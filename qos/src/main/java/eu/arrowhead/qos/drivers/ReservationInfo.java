/*
 *  Copyright (c) 2018 AITIA International Inc.
 *
 *  This work is part of the Productive 4.0 innovation project, which receives grants from the
 *  European Commissions H2020 research and innovation programme, ECSEL Joint Undertaking
 *  (project no. 737459), the free state of Saxony, the German Federal Ministry of Education and
 *  national funding authorities from involved countries.
 */

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * This work was supported by National Funds through FCT (Portuguese
 * Foundation for Science and Technology) and by the EU ECSEL JU
 * funding, within Arrowhead project, ref. ARTEMIS/0001/2012,
 * JU grant nr. 332987.
 * ISEP, Polytechnic Institute of Porto.
 */
package eu.arrowhead.qos.drivers;

import eu.arrowhead.common.database.ArrowheadService;
import eu.arrowhead.common.database.ArrowheadSystem;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Paulo
 */
public class ReservationInfo {

  private Map<String, String> networkConfiguration = new HashMap<>();
  private ArrowheadSystem provider;
  private ArrowheadSystem consumer;
  private ArrowheadService service;
  private Map<String, String> commands = new HashMap<>();
  private Map<String, String> requestedQoS = new HashMap<>();

  public ReservationInfo() {
  }

  public ReservationInfo(Map<String, String> networkConfiguration, ArrowheadSystem provider, ArrowheadSystem consumer, ArrowheadService service, Map<String, String> commands, Map<String, String> requestedQoS) {
    this.networkConfiguration = networkConfiguration;
    this.provider = provider;
    this.consumer = consumer;
    this.service = service;
    this.commands = commands;
    this.requestedQoS = requestedQoS;
  }

  public Map<String, String> getNetworkConfiguration() {
    return networkConfiguration;
  }

  public void setNetworkConfiguration(Map<String, String> networkConfiguration) {
    this.networkConfiguration = networkConfiguration;
  }

  public ArrowheadSystem getProvider() {
    return provider;
  }

  public void setProvider(ArrowheadSystem provider) {
    this.provider = provider;
  }

  public ArrowheadSystem getConsumer() {
    return consumer;
  }

  public void setConsumer(ArrowheadSystem consumer) {
    this.consumer = consumer;
  }

  public ArrowheadService getService() {
    return service;
  }

  public void setService(ArrowheadService service) {
    this.service = service;
  }

  public Map<String, String> getCommands() {
    return commands;
  }

  public void setCommands(Map<String, String> commands) {
    this.commands = commands;
  }

  public Map<String, String> getRequestedQoS() {
    return requestedQoS;
  }

  public void setRequestedQoS(Map<String, String> requestedQoS) {
    this.requestedQoS = requestedQoS;
  }

}
