module Api::V1
  class StoreController < ApplicationController
    include Concerns::MediaType

    def create
      params[:input].each do |row|
        item = Item.new(item_attrs(row))
        repository.save(item.result)
      end

      render(nothing: true, status: :no_content)
    rescue ArgumentError => error
      render(nothing: true, status: :unprocessable_entity)
    rescue StandardError => error
      render(nothing: true, status: :internal_server_error)
    end

    private

    def item_attrs(row)
      splited_row = row.split(':')
      splited_last_slice_row = splited_row.last.strip.split(',')

      {
        array: splited_row.first.split(' ').map { |item| Integer(item) },
        circular_right_rotation: Integer(splited_last_slice_row.first),
        index: Integer(splited_last_slice_row.second)
      }
    end

    def repository
      @repository ||= ResultRepository.new
    end
  end
end
