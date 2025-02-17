import Component from "@glimmer/component";
import { cached } from "@glimmer/tracking";
import { tracked } from "@glimmer/tracking";
import { hash } from "@ember/helper";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import BackButton from "discourse/components/back-button";
import ConditionalLoadingSpinner from "discourse/components/conditional-loading-spinner";
import DButton from "discourse/components/d-button";
import Form from "discourse/components/form";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import { bind } from "discourse/lib/decorators";
import getURL from "discourse/lib/get-url";
import { i18n } from "discourse-i18n";
import AdminConfigAreaCardSection from "admin/components/admin-config-area-card-section";
import SimpleList from "admin/components/simple-list";

export default class AdminBrandingLogoForm extends Component {
  @tracked placeholders = {};
  @tracked loading = false;
  EmberObject;

  constructor() {
    super(...arguments);
    this.#loadPlaceholders();
  }

  @bind
  async #loadPlaceholders() {
    this.loading = true;
    try {
      const result = await ajax("/admin/config/site_settings.json", {
        data: {
          categories: ["branding"],
        },
      });

      result.site_settings.forEach((setting) => {
        if (setting.placeholder) {
          this.placeholders[setting.setting] = setting.placeholder;
        }
      });
    } catch (error) {
      // eslint-disable-next-line no-console
      console.warn(`Failed to load settings with error: ${error}`);
    } finally {
      this.loading = false;
    }
  }

  @action
  handleUpload(type, upload, { set }) {
    if (upload) {
      set(type, getURL(upload.url));
    } else {
      set(type, undefined);
    }
  }

  <template>
    <ConditionalLoadingSpinner @condition={{this.loading}}>
      <@form.Field
        @name="logo"
        @title={{i18n "admin.config.branding.logo.form.logo.title"}}
        @description={{i18n "admin.config.branding.logo.form.logo.description"}}
        @helpText={{i18n "admin.config.branding.logo.form.logo.help_text"}}
        @onSet={{(fn this.handleUpload "logo")}}
        as |field|
      >
        <field.Image @type="branding" />
      </@form.Field>
      <@form.Field
        @name="logo_dark_required"
        @title={{i18n "admin.config.branding.logo.form.logo_dark.required"}}
        @format="full"
        as |field|
      >
        <field.Toggle />
      </@form.Field>
      {{#if @transientData.logo_dark_required}}
        <@form.Field
          @name="logo_dark"
          @title={{i18n "admin.config.branding.logo.form.logo_dark.title"}}
          @helpText={{i18n
            "admin.config.branding.logo.form.logo_dark.help_text"
          }}
          @onSet={{(fn this.handleUpload "logo_dark")}}
          as |field|
        >
          <field.Image @type="branding" />
        </@form.Field>
      {{/if}}
      <@form.Field
        @name="large_icon"
        @title={{i18n "admin.config.branding.logo.form.large_icon.title"}}
        @description={{i18n
          "admin.config.branding.logo.form.large_icon.description"
        }}
        @helpText={{i18n
          "admin.config.branding.logo.form.large_icon.help_text"
        }}
        @onSet={{(fn this.handleUpload "large_icon")}}
        @placeholderUrl={{this.placeholders.large_icon}}
        as |field|
      >
        <field.Image @type="branding" />
      </@form.Field>
      <@form.Field
        @name="favicon"
        @title={{i18n "admin.config.branding.logo.form.favicon.title"}}
        @description={{i18n
          "admin.config.branding.logo.form.favicon.description"
        }}
        @onSet={{(fn this.handleUpload "square_icon_light")}}
        @placeholderUrl={{this.placeholders.favicon}}
        as |field|
      >
        <field.Image @type="branding" />
      </@form.Field>
      <@form.Field
        @name="logo_small"
        @title={{i18n "admin.config.branding.logo.form.logo_small.title"}}
        @description={{i18n
          "admin.config.branding.logo.form.logo_small.description"
        }}
        @helpText={{i18n
          "admin.config.branding.logo.form.logo_small.help_text"
        }}
        @onSet={{(fn this.handleUpload "logo_small")}}
        as |field|
      >
        <field.Image @type="branding" />
      </@form.Field>
      <@form.Field
        @name="logo_small_dark_required"
        @title={{i18n
          "admin.config.branding.logo.form.logo_small_dark.required"
        }}
        @format="full"
        as |field|
      >
        <field.Toggle />
      </@form.Field>
      {{#if @transientData.logo_small_dark_required}}
        <@form.Field
          @name="logo_small_dark"
          @title={{i18n
            "admin.config.branding.logo.form.logo_small_dark.title"
          }}
          @helpText={{i18n
            "admin.config.branding.logo.form.logo_small_dark.help_text"
          }}
          @onSet={{(fn this.handleUpload "logo_small_dark")}}
          as |field|
        >
          <field.Image @type="branding" />
        </@form.Field>
      {{/if}}

      <AdminConfigAreaCardSection
        @heading="admin.config.branding.logo.form.mobile"
        @collapsable={{true}}
        @collapsed={{true}}
      >
        <:content>
          <@form.Field
            @name="mobile_logo"
            @title={{i18n "admin.config.branding.logo.form.mobile_logo.title"}}
            @description={{i18n
              "admin.config.branding.logo.form.mobile_logo.description"
            }}
            @helpText={{i18n
              "admin.config.branding.logo.form.mobile_logo.help_text"
            }}
            @onSet={{(fn this.handleUpload "mobile_logo")}}
            @placeholderUrl={{this.placeholders.mobile_logo}}
            as |field|
          >
            <field.Image @type="branding" />
          </@form.Field>
          <@form.Field
            @name="mobile_logo_dark_required"
            @title={{i18n
              "admin.config.branding.logo.form.mobile_logo_dark.required"
            }}
            @format="full"
            as |field|
          >
            <field.Toggle />
          </@form.Field>
          {{#if @transientData.mobile_logo_dark_required}}
            <@form.Field
              @name="mobile_logo_dark"
              @title={{i18n
                "admin.config.branding.logo.form.mobile_logo_dark.title"
              }}
              @helpText={{i18n
                "admin.config.branding.logo.form.mobile_logo_dark.help_text"
              }}
              @onSet={{(fn this.handleUpload "mobile_logo_dark")}}
              as |field|
            >
              <field.Image @type="branding" />
            </@form.Field>
          {{/if}}
          <@form.Field
            @name="manifest_icon"
            @title={{i18n
              "admin.config.branding.logo.form.manifest_icon.title"
            }}
            @description={{i18n
              "admin.config.branding.logo.form.manifest_icon.description"
            }}
            @helpText={{i18n
              "admin.config.branding.logo.form.manifest_icon.help_text"
            }}
            @onSet={{(fn this.handleUpload "manifest_icon")}}
            as |field|
          >
            <field.Image @type="branding" />
          </@form.Field>
          <@form.Field
            @name="manifest_screenshots"
            @title={{i18n
              "admin.config.branding.logo.form.manifest_screenshots.title"
            }}
            @description={{i18n
              "admin.config.branding.logo.form.manifest_screenshots.description"
            }}
            @format="full"
            as |field|
          >
            <field.Custom>
              <SimpleList
                @id={{field.id}}
                @onChange={{field.set}}
                @inputDelimiter="|"
                @values={{field.value}}
                @allowAny={{true}}
              />
            </field.Custom>
          </@form.Field>
          <@form.Field
            @name="apple_touch_icon"
            @title={{i18n
              "admin.config.branding.logo.form.apple_touch_icon.title"
            }}
            @description={{i18n
              "admin.config.branding.logo.form.apple_touch_icon.description"
            }}
            @helpText={{i18n
              "admin.config.branding.logo.form.apple_touch_icon.help_text"
            }}
            @onSet={{(fn this.handleUpload "apple_touch_icon")}}
            @placeholderUrl={{this.placeholders.apple_touch_icon}}
            as |field|
          >
            <field.Image @type="branding" />
          </@form.Field>
        </:content>
      </AdminConfigAreaCardSection>
      <AdminConfigAreaCardSection
        @heading="admin.config.branding.logo.form.email"
        @collapsable={{true}}
        @collapsed={{true}}
      >
        <:content>
          <@form.Field
            @name="digest_logo"
            @title={{i18n "admin.config.branding.logo.form.digest_logo.title"}}
            @description={{i18n
              "admin.config.branding.logo.form.digest_logo.description"
            }}
            @helpText={{i18n
              "admin.config.branding.logo.form.digest_logo.help_text"
            }}
            @onSet={{(fn this.handleUpload "digest_logo")}}
            @placeholderUrl={{this.placeholders.digest_logo}}
            as |field|
          >
            <field.Image
              @type="branding"
              @placeholderUrl={{this.placeholders.digest_logo}}
            />
          </@form.Field>
        </:content>
      </AdminConfigAreaCardSection>
      <AdminConfigAreaCardSection
        @heading="admin.config.branding.logo.form.social_media"
        @collapsable={{true}}
        @collapsed={{true}}
      >
        <:content>
          <@form.Field
            @name="opengraph_image"
            @title={{i18n
              "admin.config.branding.logo.form.opengraph_image.title"
            }}
            @description={{i18n
              "admin.config.branding.logo.form.opengraph_image.description"
            }}
            @onSet={{(fn this.handleUpload "opengraph_image")}}
            @placeholderUrl={{this.placeholders.opengraph_image}}
            as |field|
          >
            <field.Image @type="branding" />
          </@form.Field>
        </:content>
      </AdminConfigAreaCardSection>
    </ConditionalLoadingSpinner>
  </template>
}
