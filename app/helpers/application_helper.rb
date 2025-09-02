module ApplicationHelper

  def enum_display_name(model, attribute, value)
    model_key = model.class.name == 'User' ? 'post' : model.model_name.i18n_key
    t("activerecord.attributes.#{model_key}.#{attribute}.#{value}")
  end

  def like_button_for(post)
    if user_signed_in? && post.liked_by?(current_user)
      # いいね済みの場合：赤いハートで削除リンク
      button_to post_like_path(post), method: :delete, remote: true,
                class: "like-button liked",
                id: "like-button-#{post.id}",
                data: { turbo_method: :delete } do
        content_tag(:span, raw('<svg width="16" height="16" viewBox="0 0 24 24" fill="#e91e63"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>') + " #{post.likes_count}", class: "like-count")
      end
    else
      # 未いいねの場合：空ハートで作成リンク
      button_to post_like_path(post), remote: true,
                class: "like-button",
                id: "like-button-#{post.id}",
                data: { turbo_method: :post } do
        content_tag(:span, raw('<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="2"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 1 0-7.78 7.78L12 21.23l8.84-8.84a5.5 5.5 0 0 0 0-7.78z"/></svg>') + " #{post.likes_count}", class: "like-count")
      end
    end
  end
end
