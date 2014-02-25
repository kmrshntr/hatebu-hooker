class User < ActiveRecord::Base
  def can_post?(key, status, comment)
    if ret = hatena_bookmark_web_hook_key == key && status == "add"
      if include_tags.present?
        ret = include_tags.split(' ').map{ |tag| "[#{tag}]" }.any? { |tag| comment.include?(tag) }
      end
      if exclude_tags.present?
        ret = !exclude_tags.split(' ').map{ |tag| "[#{tag}]" }.any? { |tag| comment.include?(tag) }
      end
    end
    ret
  end
end
