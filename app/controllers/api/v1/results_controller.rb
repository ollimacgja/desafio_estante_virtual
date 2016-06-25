module Api
  module V1
    class ResultsController < ApplicationController
      respond_to :json
      before_filter :find_competition, :find_athlete

      def create
        respond_with :api, :v1, @competition.results.create({ athlete: @athlete }.merge(result_params.except('competition', 'athlete')))
      end

      private

      def find_competition
        @competition = Competition.find_by_name!(result_params['competition'])
      end

      def find_athlete
        @athlete = Athlete.find_or_create_by!(name: result_params['athlete'])
      end

      def result_params
        params.require(:result).permit(:competition, :athlete, :value, :unit)
      end
    end
  end
end