# frozen_string_literal: true

module TiltifyV5Public
  module Api
    class Api
      def initialize(connection)
        @connection = connection
      end

      def public_auction_houses(auction_house_id:)
        raise ArgumentError, 'auction_house_id is required' if auction_house_id.nil?

        @connection.call(
          :GET,
          '/api/public/auction_houses/{auction_house_id}'
            .gsub('{auction_house_id}', ERB::Util.url_encode(auction_house_id.to_s)),
          type: TiltifyV5Public::Models::AuctionHouseResponse,
          auth: ['authorization']
        )
      end

      def public_auction_houses_auction_items(auction_house_id:, auction_item_id:)
        raise ArgumentError, 'auction_house_id is required' if auction_house_id.nil?
        raise ArgumentError, 'auction_item_id is required' if auction_item_id.nil?

        @connection.call(
          :GET,
          '/api/public/auction_houses/{auction_house_id}/auction_items/{auction_item_id}'
            .gsub('{auction_house_id}', ERB::Util.url_encode(auction_house_id.to_s))
            .gsub('{auction_item_id}', ERB::Util.url_encode(auction_item_id.to_s)),
          type: TiltifyV5Public::Models::AuctionItemResponse,
          auth: ['authorization']
        )
      end

      def public_auction_houses_auction_items_auction_bids(auction_house_id:, auction_item_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'auction_house_id is required' if auction_house_id.nil?
        raise ArgumentError, 'auction_item_id is required' if auction_item_id.nil?

        @connection.call(
          :GET,
          '/api/public/auction_houses/{auction_house_id}/auction_items/{auction_item_id}/auction_bids'
            .gsub('{auction_house_id}', ERB::Util.url_encode(auction_house_id.to_s))
            .gsub('{auction_item_id}', ERB::Util.url_encode(auction_item_id.to_s)),
          type: TiltifyV5Public::Models::GetAuctionHouseAuctionItemAuctionBids200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_auction_houses_auction_items_get(auction_house_id:, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, status: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'auction_house_id is required' if auction_house_id.nil?

        @connection.call(
          :GET,
          '/api/public/auction_houses/{auction_house_id}/auction_items'
            .gsub('{auction_house_id}', ERB::Util.url_encode(auction_house_id.to_s)),
          type: TiltifyV5Public::Models::GetAuctionHouseAuctionItems200Response,
          auth: ['authorization'],
          query: { 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'status' => status, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_auction_houses_by_cause_slugs(cause_slug:, auction_house_slug:)
        raise ArgumentError, 'cause_slug is required' if cause_slug.nil?
        raise ArgumentError, 'auction_house_slug is required' if auction_house_slug.nil?

        @connection.call(
          :GET,
          '/api/public/auction_houses/by/cause/slugs/{cause_slug}/{auction_house_slug}'
            .gsub('{cause_slug}', ERB::Util.url_encode(cause_slug.to_s))
            .gsub('{auction_house_slug}', ERB::Util.url_encode(auction_house_slug.to_s)),
          type: TiltifyV5Public::Models::AuctionHouseResponse,
          auth: ['authorization']
        )
      end

      def public_auction_houses_by_user_slugs(user_slug:, auction_house_slug:)
        raise ArgumentError, 'user_slug is required' if user_slug.nil?
        raise ArgumentError, 'auction_house_slug is required' if auction_house_slug.nil?

        @connection.call(
          :GET,
          '/api/public/auction_houses/by/user/slugs/{user_slug}/{auction_house_slug}'
            .gsub('{user_slug}', ERB::Util.url_encode(user_slug.to_s))
            .gsub('{auction_house_slug}', ERB::Util.url_encode(auction_house_slug.to_s)),
          type: TiltifyV5Public::Models::AuctionHouseResponse,
          auth: ['authorization']
        )
      end

      def public_campaigns(campaign_id:)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::CampaignResponse,
          auth: ['authorization']
        )
      end

      def public_campaigns_by_slugs(user_slug:, campaign_slug:)
        raise ArgumentError, 'user_slug is required' if user_slug.nil?
        raise ArgumentError, 'campaign_slug is required' if campaign_slug.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/by/slugs/{user_slug}/{campaign_slug}'
            .gsub('{user_slug}', ERB::Util.url_encode(user_slug.to_s))
            .gsub('{campaign_slug}', ERB::Util.url_encode(campaign_slug.to_s)),
          type: TiltifyV5Public::Models::CampaignResponse,
          auth: ['authorization']
        )
      end

      def public_campaigns_donation_matches(campaign_id:, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, status: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/donation_matches'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetFactDonationMatches200Response,
          auth: ['authorization'],
          query: { 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'status' => status, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_donations(campaign_id:, completed_before: nil, completed_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/donations'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignDonations200Response,
          auth: ['authorization'],
          query: { 'completed_before' => completed_before, 'completed_after' => completed_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_donor_leaderboard(campaign_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/donor_leaderboard'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_fitness_goals(campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/fitness_goals'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignFitnessGoals200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_milestones(campaign_id:, include_disabled: nil, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/milestones'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignMilestones200Response,
          auth: ['authorization'],
          query: { 'include_disabled' => include_disabled, 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_polls(campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/polls'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignPolls200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_polls_get(poll_id:, campaign_id:)
        raise ArgumentError, 'poll_id is required' if poll_id.nil?
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/polls/{poll_id}'
            .gsub('{poll_id}', ERB::Util.url_encode(poll_id.to_s))
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::PollResponse,
          auth: ['authorization']
        )
      end

      def public_campaigns_rewards(campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/rewards'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignRewards200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_schedules(campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/schedules'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetFactSchedules200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_supporting_campaigns(campaign_id:, status: nil, updated_after: nil, updated_before: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/supporting_campaigns'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetUserCampaigns200Response,
          auth: ['authorization'],
          query: { 'status' => status, 'updated_after' => updated_after, 'updated_before' => updated_before, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_targets(campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/targets'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignTargets200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_campaigns_user_leaderboard(campaign_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'campaign_id is required' if campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/campaigns/{campaign_id}/user_leaderboard'
            .gsub('{campaign_id}', ERB::Util.url_encode(campaign_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_causes(cause_id:)
        raise ArgumentError, 'cause_id is required' if cause_id.nil?

        @connection.call(
          :GET,
          '/api/public/causes/{cause_id}'
            .gsub('{cause_id}', ERB::Util.url_encode(cause_id.to_s)),
          type: TiltifyV5Public::Models::CauseResponse,
          auth: ['authorization']
        )
      end

      def public_causes_configured_leaderboard(cause_id:)
        raise ArgumentError, 'cause_id is required' if cause_id.nil?

        @connection.call(
          :GET,
          '/api/public/causes/{cause_id}/configured_leaderboard'
            .gsub('{cause_id}', ERB::Util.url_encode(cause_id.to_s)),
          type: TiltifyV5Public::Models::ConfiguredLeaderboardResponse,
          auth: ['authorization']
        )
      end

      def public_causes_donor_leaderboard(cause_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'cause_id is required' if cause_id.nil?

        @connection.call(
          :GET,
          '/api/public/causes/{cause_id}/donor_leaderboard'
            .gsub('{cause_id}', ERB::Util.url_encode(cause_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_causes_fundraising_events(cause_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'cause_id is required' if cause_id.nil?

        @connection.call(
          :GET,
          '/api/public/causes/{cause_id}/fundraising_events'
            .gsub('{cause_id}', ERB::Util.url_encode(cause_id.to_s)),
          type: TiltifyV5Public::Models::GetCauseFundraisingEvents200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_causes_team_leaderboard(cause_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'cause_id is required' if cause_id.nil?

        @connection.call(
          :GET,
          '/api/public/causes/{cause_id}/team_leaderboard'
            .gsub('{cause_id}', ERB::Util.url_encode(cause_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_causes_user_leaderboard(cause_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'cause_id is required' if cause_id.nil?

        @connection.call(
          :GET,
          '/api/public/causes/{cause_id}/user_leaderboard'
            .gsub('{cause_id}', ERB::Util.url_encode(cause_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_current_user
        @connection.call(
          :GET,
          '/api/public/current-user',
          type: TiltifyV5Public::Models::NullableUserResponse,
          auth: ['authorization']
        )
      end

      def public_facts(fact_id:)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::FactResponse,
          auth: ['authorization']
        )
      end

      def public_facts_by_slugs(slug:, fact_slug:)
        raise ArgumentError, 'slug is required' if slug.nil?
        raise ArgumentError, 'fact_slug is required' if fact_slug.nil?

        @connection.call(
          :GET,
          '/api/public/facts/by/slugs/{slug}/{fact_slug}'
            .gsub('{slug}', ERB::Util.url_encode(slug.to_s))
            .gsub('{fact_slug}', ERB::Util.url_encode(fact_slug.to_s)),
          type: TiltifyV5Public::Models::FactResponse,
          auth: ['authorization']
        )
      end

      def public_facts_configured_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/configured_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::ConfiguredLeaderboardResponse,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_contributions(fact_id:, completed_before: nil, completed_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/contributions'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetFactContributions200Response,
          auth: ['authorization'],
          query: { 'completed_before' => completed_before, 'completed_after' => completed_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_donation_matches(fact_id:, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, status: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/donation_matches'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetFactDonationMatches200Response,
          auth: ['authorization'],
          query: { 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'status' => status, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_donations(fact_id:, completed_before: nil, completed_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/donations'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignDonations200Response,
          auth: ['authorization'],
          query: { 'completed_before' => completed_before, 'completed_after' => completed_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_donor_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/donor_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_fitness_goals(fact_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/fitness_goals'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignFitnessGoals200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_milestones(fact_id:, include_disabled: nil, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/milestones'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignMilestones200Response,
          auth: ['authorization'],
          query: { 'include_disabled' => include_disabled, 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_polls(poll_id:, fact_id:)
        raise ArgumentError, 'poll_id is required' if poll_id.nil?
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/polls/{poll_id}'
            .gsub('{poll_id}', ERB::Util.url_encode(poll_id.to_s))
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::PollResponse,
          auth: ['authorization']
        )
      end

      def public_facts_polls_get(fact_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/polls'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignPolls200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_rewards(fact_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/rewards'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignRewards200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_schedules(fact_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/schedules'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetFactSchedules200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_supporting_facts(fact_id:, status: nil, updated_after: nil, updated_before: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/supporting_facts'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetFactSupportingFacts200Response,
          auth: ['authorization'],
          query: { 'status' => status, 'updated_after' => updated_after, 'updated_before' => updated_before, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_targets(fact_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/targets'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignTargets200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_team_fitness_distance_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/team_fitness_distance_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_team_fitness_time_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/team_fitness_time_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_team_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/team_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_user_fitness_distance_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/user_fitness_distance_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_user_fitness_time_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/user_fitness_time_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_facts_user_leaderboard(fact_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fact_id is required' if fact_id.nil?

        @connection.call(
          :GET,
          '/api/public/facts/{fact_id}/user_leaderboard'
            .gsub('{fact_id}', ERB::Util.url_encode(fact_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events(fundraising_event_id:)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::FundraisingEventResponse,
          auth: ['authorization']
        )
      end

      def public_fundraising_events_configured_leaderboard(fundraising_event_id:)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/configured_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::ConfiguredLeaderboardResponse,
          auth: ['authorization']
        )
      end

      def public_fundraising_events_donations(fundraising_event_id:, completed_before: nil, completed_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/donations'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignDonations200Response,
          auth: ['authorization'],
          query: { 'completed_before' => completed_before, 'completed_after' => completed_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_donor_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/donor_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_fitness_goals(fundraising_event_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/fitness_goals'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignFitnessGoals200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_supporting_events(fundraising_event_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/supporting_events'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::GetFundraisingEventSupportingEvents200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_team_fitness_distance_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/team_fitness_distance_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_team_fitness_time_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/team_fitness_time_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_team_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/team_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_user_fitness_distance_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/user_fitness_distance_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_user_fitness_time_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/user_fitness_time_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_fundraising_events_user_leaderboard(fundraising_event_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'fundraising_event_id is required' if fundraising_event_id.nil?

        @connection.call(
          :GET,
          '/api/public/fundraising_events/{fundraising_event_id}/user_leaderboard'
            .gsub('{fundraising_event_id}', ERB::Util.url_encode(fundraising_event_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_legacy_relays(provider:, uuid:)
        raise ArgumentError, 'provider is required' if provider.nil?
        raise ArgumentError, 'uuid is required' if uuid.nil?

        @connection.call(
          :GET,
          '/api/public/legacy-relays/{provider}/{uuid}'
            .gsub('{provider}', ERB::Util.url_encode(provider.to_s))
            .gsub('{uuid}', ERB::Util.url_encode(uuid.to_s)),
          type: TiltifyV5Public::Models::LegacyRelayResponse,
          auth: ['authorization']
        )
      end

      def public_personal_campaigns(personal_campaign_id:)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::PersonalCampaignResponse,
          auth: ['authorization']
        )
      end

      def public_personal_campaigns_contributions(personal_campaign_id:, completed_before: nil, completed_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/contributions'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetFactContributions200Response,
          auth: ['authorization'],
          query: { 'completed_before' => completed_before, 'completed_after' => completed_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_personal_campaigns_milestones(personal_campaign_id:, include_disabled: nil, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/milestones'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignMilestones200Response,
          auth: ['authorization'],
          query: { 'include_disabled' => include_disabled, 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_personal_campaigns_polls(poll_id:, personal_campaign_id:)
        raise ArgumentError, 'poll_id is required' if poll_id.nil?
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/polls/{poll_id}'
            .gsub('{poll_id}', ERB::Util.url_encode(poll_id.to_s))
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::PollResponse,
          auth: ['authorization']
        )
      end

      def public_personal_campaigns_polls_get(personal_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/polls'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignPolls200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_personal_campaigns_rewards(personal_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/rewards'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignRewards200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_personal_campaigns_schedules(personal_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/schedules'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetFactSchedules200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_personal_campaigns_supporting_campaigns(personal_campaign_id:, status: nil, updated_after: nil, updated_before: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/supporting_campaigns'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetPersonalCampaignSupportingCampaigns200Response,
          auth: ['authorization'],
          query: { 'status' => status, 'updated_after' => updated_after, 'updated_before' => updated_before, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_personal_campaigns_targets(personal_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'personal_campaign_id is required' if personal_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/personal-campaigns/{personal_campaign_id}/targets'
            .gsub('{personal_campaign_id}', ERB::Util.url_encode(personal_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignTargets200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns(team_campaign_id:)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::TeamCampaignResponse,
          auth: ['authorization']
        )
      end

      def public_team_campaigns_by_slugs(team_slug:, team_campaign_slug:)
        raise ArgumentError, 'team_slug is required' if team_slug.nil?
        raise ArgumentError, 'team_campaign_slug is required' if team_campaign_slug.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/by/slugs/{team_slug}/{team_campaign_slug}'
            .gsub('{team_slug}', ERB::Util.url_encode(team_slug.to_s))
            .gsub('{team_campaign_slug}', ERB::Util.url_encode(team_campaign_slug.to_s)),
          type: TiltifyV5Public::Models::TeamCampaignResponse,
          auth: ['authorization']
        )
      end

      def public_team_campaigns_donations(team_campaign_id:, completed_before: nil, completed_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/donations'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignDonations200Response,
          auth: ['authorization'],
          query: { 'completed_before' => completed_before, 'completed_after' => completed_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_donor_leaderboards(team_campaign_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/donor_leaderboards'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_fitness_goals(team_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/fitness_goals'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignFitnessGoals200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_milestones(team_campaign_id:, include_disabled: nil, created_before: nil, created_after: nil, updated_before: nil, updated_after: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/milestones'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignMilestones200Response,
          auth: ['authorization'],
          query: { 'include_disabled' => include_disabled, 'created_before' => created_before, 'created_after' => created_after, 'updated_before' => updated_before, 'updated_after' => updated_after, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_polls(team_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/polls'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignPolls200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_polls_get(poll_id:, team_campaign_id:)
        raise ArgumentError, 'poll_id is required' if poll_id.nil?
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/polls/{poll_id}'
            .gsub('{poll_id}', ERB::Util.url_encode(poll_id.to_s))
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::PollResponse,
          auth: ['authorization']
        )
      end

      def public_team_campaigns_rewards(team_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/rewards'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetCampaignRewards200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_schedules(team_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/schedules'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetFactSchedules200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_supporting_campaigns(team_campaign_id:, status: nil, updated_after: nil, updated_before: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/supporting_campaigns'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetUserCampaigns200Response,
          auth: ['authorization'],
          query: { 'status' => status, 'updated_after' => updated_after, 'updated_before' => updated_before, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_targets(team_campaign_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/targets'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaignTargets200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_team_campaigns_user_leaderboards(team_campaign_id:, time_type: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_campaign_id is required' if team_campaign_id.nil?

        @connection.call(
          :GET,
          '/api/public/team_campaigns/{team_campaign_id}/user_leaderboards'
            .gsub('{team_campaign_id}', ERB::Util.url_encode(team_campaign_id.to_s)),
          type: TiltifyV5Public::Models::V5ApiWebPublicFundraisingEventLeaderboardControllerDonHeaaf43f9,
          auth: ['authorization'],
          query: { 'time_type' => time_type, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_teams(team_id:)
        raise ArgumentError, 'team_id is required' if team_id.nil?

        @connection.call(
          :GET,
          '/api/public/teams/{team_id}'
            .gsub('{team_id}', ERB::Util.url_encode(team_id.to_s)),
          type: TiltifyV5Public::Models::TeamResponse,
          auth: ['authorization']
        )
      end

      def public_teams_by_slug(slug:)
        raise ArgumentError, 'slug is required' if slug.nil?

        @connection.call(
          :GET,
          '/api/public/teams/by/slug/{slug}'
            .gsub('{slug}', ERB::Util.url_encode(slug.to_s)),
          type: TiltifyV5Public::Models::TeamResponse,
          auth: ['authorization']
        )
      end

      def public_teams_members(team_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_id is required' if team_id.nil?

        @connection.call(
          :GET,
          '/api/public/teams/{team_id}/members'
            .gsub('{team_id}', ERB::Util.url_encode(team_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamMembers200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_teams_team_campaigns(team_id:, status: nil, supporting_type: nil, updated_after: nil, updated_before: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'team_id is required' if team_id.nil?

        @connection.call(
          :GET,
          '/api/public/teams/{team_id}/team_campaigns'
            .gsub('{team_id}', ERB::Util.url_encode(team_id.to_s)),
          type: TiltifyV5Public::Models::GetTeamCampaigns200Response,
          auth: ['authorization'],
          query: { 'status' => status, 'supporting_type' => supporting_type, 'updated_after' => updated_after, 'updated_before' => updated_before, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_users(user_id:)
        raise ArgumentError, 'user_id is required' if user_id.nil?

        @connection.call(
          :GET,
          '/api/public/users/{user_id}'
            .gsub('{user_id}', ERB::Util.url_encode(user_id.to_s)),
          type: TiltifyV5Public::Models::UserResponse,
          auth: ['authorization']
        )
      end

      def public_users_by_slug(slug:)
        raise ArgumentError, 'slug is required' if slug.nil?

        @connection.call(
          :GET,
          '/api/public/users/by/slug/{slug}'
            .gsub('{slug}', ERB::Util.url_encode(slug.to_s)),
          type: TiltifyV5Public::Models::UserResponse,
          auth: ['authorization']
        )
      end

      def public_users_campaigns(user_id:, status: nil, supporting_type: nil, updated_after: nil, updated_before: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'user_id is required' if user_id.nil?

        @connection.call(
          :GET,
          '/api/public/users/{user_id}/campaigns'
            .gsub('{user_id}', ERB::Util.url_encode(user_id.to_s)),
          type: TiltifyV5Public::Models::GetUserCampaigns200Response,
          auth: ['authorization'],
          query: { 'status' => status, 'supporting_type' => supporting_type, 'updated_after' => updated_after, 'updated_before' => updated_before, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_users_integration_events(user_id:, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'user_id is required' if user_id.nil?

        @connection.call(
          :GET,
          '/api/public/users/{user_id}/integration_events'
            .gsub('{user_id}', ERB::Util.url_encode(user_id.to_s)),
          type: TiltifyV5Public::Models::GetFundraisingEventSupportingEvents200Response,
          auth: ['authorization'],
          query: { 'after' => after, 'before' => before, 'limit' => limit }
        )
      end

      def public_users_teams(user_id:, role: nil, after: nil, before: nil, limit: nil)
        raise ArgumentError, 'user_id is required' if user_id.nil?

        @connection.call(
          :GET,
          '/api/public/users/{user_id}/teams'
            .gsub('{user_id}', ERB::Util.url_encode(user_id.to_s)),
          type: TiltifyV5Public::Models::GetUserTeams200Response,
          auth: ['authorization'],
          query: { 'role' => role, 'after' => after, 'before' => before, 'limit' => limit }
        )
      end
    end
  end
end
