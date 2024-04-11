module ActiveRecord::Associations::Builder # rubocop:disable Style/ClassAndModuleChildren, Style/FrozenStringLiteralComment
  class HasManyForActiveModel < HasMany
    if ActiveRecord.version >= Gem::Version.new("5.0.0.beta")
      AR_CALLBACK_METHODS = %i(define_callback before_validation after_validation before_save
                               after_save before_update after_update)

      def self.valid_options(_options)
        super + [:active_model,
                 :target_ids] - [:through, :dependent, :source, :source_type, :counter_cache, :as]
      end

      def self.define_callbacks(model, reflection)
        return unless AR_CALLBACK_METHODS.all? { |meth| self.respond_to?(meth) }

        super
      end
    else
      def valid_options
        super + [:active_model,
                 :target_ids] - [:through, :dependent, :source, :source_type, :counter_cache, :as]
      end
    end
  end
end
