module ApplicationHelper

  def enum_display_name(model, attribute, value)
    model_key = model.class.name == 'User' ? 'post' : model.model_name.i18n_key
    t("activerecord.attributes.#{model_key}.#{attribute}.#{value}")
  end
end
