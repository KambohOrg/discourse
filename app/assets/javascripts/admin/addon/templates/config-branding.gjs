import RouteTemplate from "ember-route-template";
import DBreadcrumbsItem from "discourse/components/d-breadcrumbs-item";
import DPageHeader from "discourse/components/d-page-header";
import { i18n } from "discourse-i18n";
import AdminBrandingLogoForm from "admin/components/admin-branding-logo-form";
import AdminConfigAreaCard from "admin/components/admin-config-area-card";
import AdminConfigAreasBrandingForm from "admin/components/admin-config-areas/branding-form";

export default RouteTemplate(
  <template>
  <DPageHeader
    @hideTabs={{true}}
    @titleLabel={{i18n "admin.config.branding.title"}}
  >
    <:breadcrumbs>
      <DBreadcrumbsItem @path="/admin" @label={{i18n "admin_title"}} />
      <DBreadcrumbsItem
        @path="/admin/config/branding"
        @label={{i18n "admin.config.branding.title"}}
      />
    </:breadcrumbs>
  </DPageHeader>

  <div class="admin-config-area">
    <div class="admin-config-area__primary-content">
      <AdminConfigAreasBrandingForm>
        <:content as |form transientData|>
          <AdminConfigAreaCard
            @heading="admin.config.branding.logo.title"
            @collapsable={{true}}
            class="admin-config-area-branding__logo"
          >
            <:content>
              <AdminBrandingLogoForm @form={{form}} @transientData={{transientData}} />
            </:content>
          </AdminConfigAreaCard>
        </:content>
      </AdminConfigAreasBrandingForm>
    </div>
  </div>
</template>
);
