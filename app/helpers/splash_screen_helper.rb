# frozen_string_literal: true

module SplashScreenHelper
  def self.raw_js
    if Rails.env.development?
      load_js
    else
      @loaded_js ||= load_js
    end.html_safe
  end

  private

  def self.load_js
    # TODO - this is no longer babel-ified, we should fix that
    File.read("#{Rails.root}/app/assets/javascripts/discourse/scripts/splash-screen.js").sub(
      "//# sourceMappingURL=splash-screen.map",
      "",
    )
  rescue Errno::ENOENT
    Rails.logger.error("Unable to load splash screen JS") if Rails.env.production?
    "console.log('Unable to load splash screen JS')"
  end
end
