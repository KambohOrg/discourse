import Component from "@glimmer/component";
import { cached } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import Form from "discourse/components/form";

export default class AdminConfigAreasBrandingForm extends Component {
  @service siteSettings;
  @service site;

  @action
  submit(args) {
    console.log("args", args);
  }

  @cached
  get formData() {
    return {
      logo: this.siteSettings.logo,
      logo_dark_required: !!this.siteSettings.logo_dark,
      logo_dark: this.siteSettings.logo_dark,
      large_icon: this.siteSettings.large_icon,
      favicon: this.siteSettings.favicon,
      logo_small: this.siteSettings.logo_small,
      logo_small_dark_required: !!this.siteSettings.logo_small_dark,
      logo_small_dark: this.siteSettings.logo_small_dark,
      mobile_logo: this.siteSettings.mobile_logo,
      mobile_logo_dark_required: !!this.siteSettings.mobile_logo_dark,
      mobile_logo_dark: this.siteSettings.mobile_logo_dark,
      manifest_icon: this.siteSettings.manifest_icon,
      manifest_screenshots: this.siteSettings.manifest_screenshots,
      apple_touch_icon: this.siteSettings.apple_touch_icon,
      digest_logo: this.siteSettings.digest_logo,
      opengraph_image: this.siteSettings.opengraph_image,
      x_summary_large_image: this.siteSettings.x_summary_large_image,
    };
  }

  <template>
    <Form
      @onSubmit={{this.submit}}
      @data={{this.formData}}
      as |form transientData|
    >
      {{yield form transientData to="content"}}
      <form.Submit />
    </Form>
  </template>
}
