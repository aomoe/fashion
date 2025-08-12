module ApplicationHelper

  def enum_display_name(model, attribute, value)
    t("activerecord.attributes.#{model.model_name.i18n_key}.#{attribute}.#{value}")
  end
end
