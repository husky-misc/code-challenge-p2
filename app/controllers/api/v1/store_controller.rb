module Api::V1
  class StoreController < ApplicationController
    include Concerns::MediaType

    def create
      repository = ResultRepository.new
      repository.save(items.collect(&:result))

      render(nothing: true, status: :no_content)
    rescue ArgumentError => error
      render(nothing: true, status: :unprocessable_entity)
    rescue StandardError => error
      render(nothing: true, status: :internal_server_error)
    end

    private

    def items
      params[:input].map { |row| map_item(row) }
    end

    def map_item(row)
      splited_row = row.split(':')
      splited_last_slice_row = splited_row.last.strip.split(',')

      Item.new({
        array: splited_row.first.split(' ').map { |item| Integer(item) },
        circular_right_rotation: Integer(splited_last_slice_row.first),
        index: Integer(splited_last_slice_row.second)
      })
    end
  end
end
