require 'cfn-nag/violation'
require_relative 'base'

class EC2AvailabilityZoneRule < BaseRule
  def rule_text
    'EC2 Subnet are only allowed in US-East-1 Availability Zones'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'F80'
  end

  def audit_impl(cfn_model)
    violating_subnet_az = cfn_model.resources_by_type('AWS::EC2::Subnet')
                            .select do |subnet|
        subnet.availabilityZone["us-east-1"].nil?

    end

    violating_subnet_az.map(&:logical_resource_id)
  end


end