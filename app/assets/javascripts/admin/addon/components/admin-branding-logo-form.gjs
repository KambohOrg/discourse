import Component from "@glimmer/component";
import { cached } from "@glimmer/tracking";
import { tracked } from "@glimmer/tracking";
import { hash } from "@ember/helper";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import BackButton from "discourse/components/back-button";
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
  @service router;
  @service site;

  @action
  handleUpload(type, upload, { set }) {
    if (upload) {
      set(type, getURL(upload.url));
    } else {
      set(type, undefined);
    }
  }

  <template>
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
        @helpText={{i18n "admin.config.branding.logo.form.logo_dark.help_text"}}
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
      @helpText={{i18n "admin.config.branding.logo.form.large_icon.help_text"}}
      @onSet={{(fn this.handleUpload "large_icon")}}
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
      @helpText={{i18n "admin.config.branding.logo.form.logo_small.help_text"}}
      @onSet={{(fn this.handleUpload "logo_small")}}
      as |field|
    >
      <field.Image @type="branding" />
    </@form.Field>
    <@form.Field
      @name="logo_small_dark_required"
      @title={{i18n "admin.config.branding.logo.form.logo_small_dark.required"}}
      @format="full"
      as |field|
    >
      <field.Toggle />
    </@form.Field>
    {{#if @transientData.logo_small_dark_required}}
      <@form.Field
        @name="logo_small_dark"
        @title={{i18n "admin.config.branding.logo.form.logo_small_dark.title"}}
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
          @title={{i18n "admin.config.branding.logo.form.manifest_icon.title"}}
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
      </:content>
    </AdminConfigAreaCardSection>
    <AdminConfigAreaCardSection
      @heading="admin.config.branding.logo.form.email"
      @collapsable={{true}}
      @collapsed={{true}}
    >
      <:content>
        fsdfgsdfsdf ds fsdf sdfsd
      </:content>
    </AdminConfigAreaCardSection>
    <AdminConfigAreaCardSection
      @heading="admin.config.branding.logo.form.social_media"
      @collapsable={{true}}
      @collapsed={{true}}
    >
      <:content>
        fsdfgsdfsdf ds fsdf sdfsd
      </:content>
    </AdminConfigAreaCardSection>
  </template>
}
