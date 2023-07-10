# frozen_string_literal: true

require 'kaminari/activerecord/active_record_relation_methods'

module Kaminari
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      include Kaminari::ConfigurationMethods

      # Fetch the values at the specified page number
      #   Model.page(5)
      define_singleton_method Kaminari.config.page_method_name do |num = nil|
        per_page = max_per_page && (default_per_page > max_per_page) ? max_per_page : default_per_page
        limit(per_page).offset(per_page * ((num = num.to_i - 1) < 0 ? 0 : num)).extending do
          include Kaminari::ActiveRecordRelationMethods
          include Kaminari::PageScopeMethods
        end
      end
    end
  end
end
