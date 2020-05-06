require 'spec_helper'
require 'cfn-model'
require 'cfn-nag/custom_rules/AllowableAwsServicesRuleGameLift'

describe AllowableAwsServicesRuleGameLift do
  context 'GameLift is a declared resource' do
    it 'returns offending logical resource id' do
      cfn_model = CfnParser.new.parse read_test_template(
                                          'yaml/allowable_aws_services/gamelift_resource.yml'
                                      )

      actual_logical_resource_ids = AllowableAwsServicesRuleGameLift.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[NewGameLift]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'GameLift is not a declared resource' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
                                          'yaml/allowable_aws_services/no_gamelift_resource.yml'
                                      )

      actual_logical_resource_ids = AllowableAwsServicesRuleGameLift.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end
end

