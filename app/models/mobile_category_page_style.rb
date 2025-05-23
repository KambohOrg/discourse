# frozen_string_literal: true

require "enum_site_setting"

class MobileCategoryPageStyle < EnumSiteSetting
  def self.valid_value?(val)
    values.any? { |v| v[:value].to_s == val.to_s }
  end

  def self.values
    @values ||= [
      { name: "category_page_style.categories_only", value: "categories_only" },
      {
        name: "category_page_style.categories_with_featured_topics",
        value: "categories_with_featured_topics",
      },
      { name: "category_page_style.categories_boxes", value: "categories_boxes" },
      {
        name: "category_page_style.categories_boxes_with_topics",
        value: "categories_boxes_with_topics",
      },
      {
        name: "category_page_style.subcategories_with_featured_topics",
        value: "subcategories_with_featured_topics",
      },
    ]
  end

  def self.translate_names?
    true
  end
end
