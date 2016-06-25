module Api
  module V1
    class CompetitionsController < ApplicationController
      respond_to :json
      before_filter :find_competition, except: :create

      def create
        respond_with :api, :v1, Competition.create(competition_params)
      end

      def ranking
        respond_with @competition.build_ranking_hash, location: api_v1_competition_url(@competition), status: 200
      end

      def finish_competition
        @competition.finish_competition
        respond_with @competition.save ? I18n.t('activerecord.models.attributes.competition.finished_success') : @competition, location: api_v1_competition_url(@competition), status: 200
      end

      private

      def find_competition
        @competition = Competition.find_by_name!(competition_params['name'])
      end

      def competition_params
        params.require(:competition).permit(:name, :competition_type)
      end
    end
  end
end