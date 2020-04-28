require 'spec_helper'
require 'cfn-model'
require 'cfn-nag/custom_rules/EC2AvailabilityZoneRule'

describe EC2AvailabilityZoneRule do
  context 'EC2 Subnet are only allowed in US-East-1 Availability Zones' do
    it 'returns offending logical resource id' do
      cfn_model = CfnParser.new.parse read_test_template('yaml/ec2_subnet/ec2_subnet_avail_zone_incorrect.yml')

      actual_logical_resource_ids = EC2AvailabilityZoneRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[EC2Subnet]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end
end

