module Concerns
  module MediaType
    extend ActiveSupport::Concern

    included do
      before_action :filter_content_type!
    end

    private

    def filter_content_type!
      return render(:nothing, status: :unsupported_media_type) unless json_request?
    end

    def json_request?
      format_url = request.path_parameters[:format]

      return false if format_url.present? && format_url != 'json'
      request.content_type == 'application/json'
    end
  end
end
