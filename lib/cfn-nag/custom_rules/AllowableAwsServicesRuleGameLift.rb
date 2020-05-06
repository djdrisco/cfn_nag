# frozen_string_literal: true

require 'cfn-nag/violation'
require_relative 'resource_base_rule'

class AllowableAwsServicesRuleGameLift < BaseRule
  def rule_text
    'This Aws Service is not currently allowed for use.'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'F81'
  end


  def audit_impl(cfn_model)

    gamelift_resources = ['AWS::GameLift::Alias','AWS::GameLift::Build','AWS::GameLift::Fleet','AWS::GameLift::GameSessionQueue','AWS::GameLift::MatchmakingConfiguration','AWS::GameLift::MatchmakingRuleSet','AWS::GameLift::Alias']

    violating_service_gamelift = []
    gamelift_resources.each do |resource_item|
      if(not cfn_model.resources_by_type(resource_item).empty?)
        violating_service_gamelift.push(cfn_model.resources_by_type(resource_item))
      end
    end

    violating_service_gamelift.flatten.map(&:logical_resource_id)


  end
end

