import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "discourse/tests/helpers/component-test";
import { i18n } from "discourse-i18n";
import PollInfo from "discourse/plugins/poll/discourse/components/poll-info";

const OPTIONS = [
  { id: "1ddc47be0d2315b9711ee8526ca9d83f", html: "This", votes: 2, rank: 0 },
  { id: "70e743697dac09483d7b824eaadb91e1", html: "That", votes: 3, rank: 0 },
  { id: "6c986ebcde3d5822a6e91a695c388094", html: "Other", votes: 5, rank: 0 },
];

module("Poll | Component | poll-info", function (hooks) {
  setupRenderingTest(hooks);

  test("public multiple poll with results anytime", async function (assert) {
    const self = this;

    this.setProperties({
      isMultiple: true,
      min: 1,
      max: 2,
      options: OPTIONS,
      close: null,
      closed: false,
      results: [],
      showResults: false,
      postUserId: 59,
      isPublic: true,
      hasVoted: true,
      voters: [],
    });

    await render(
      <template>
        <PollInfo
          @options={{self.options}}
          @min={{self.min}}
          @max={{self.max}}
          @isMultiple={{self.isMultiple}}
          @close={{self.close}}
          @closed={{self.closed}}
          @results={{self.results}}
          @showResults={{self.showResults}}
          @postUserId={{self.postUserId}}
          @isPublic={{self.isPublic}}
          @hasVoted={{self.hasVoted}}
          @voters={{self.voters}}
        />
      </template>
    );

    assert.dom(".poll-info_instructions li.multiple-help-text").hasText(
      i18n("poll.multiple.help.up_to_max_options", {
        count: this.max,
      }).replace(/<\/?[^>]+(>|$)/g, ""),
      "displays the multiple help text"
    );

    assert
      .dom(".poll-info_instructions li.is-public")
      .hasText(
        i18n("poll.public.title").replace(/<\/?[^>]+(>|$)/g, ""),
        "displays the public label"
      );
  });

  test("public multiple poll with results only shown on vote", async function (assert) {
    const self = this;

    this.setProperties({
      isMultiple: true,
      min: 1,
      max: 2,
      options: OPTIONS,
      close: null,
      closed: false,
      results: "on_vote",
      showResults: false,
      postUserId: 59,
      isPublic: true,
      hasVoted: false,
      voters: [],
    });

    await render(
      <template>
        <PollInfo
          @options={{self.options}}
          @min={{self.min}}
          @max={{self.max}}
          @isMultiple={{self.isMultiple}}
          @close={{self.close}}
          @closed={{self.closed}}
          @results={{self.results}}
          @showResults={{self.showResults}}
          @postUserId={{self.postUserId}}
          @isPublic={{self.isPublic}}
          @hasVoted={{self.hasVoted}}
          @voters={{self.voters}}
        />
      </template>
    );

    assert.dom(".poll-info_instructions li.multiple-help-text").hasText(
      i18n("poll.multiple.help.up_to_max_options", {
        count: this.max,
      }).replace(/<\/?[^>]+(>|$)/g, ""),
      "displays the multiple help text"
    );

    assert
      .dom(".poll-info_instructions li.results-on-vote span")
      .hasText(
        i18n("poll.results.vote.title").replace(/<\/?[^>]+(>|$)/g, ""),
        "displays the results on vote label"
      );

    assert
      .dom(".poll-info_instructions li.is-public")
      .hasText(
        i18n("poll.public.title").replace(/<\/?[^>]+(>|$)/g, ""),
        "displays the public label"
      );
  });
});
