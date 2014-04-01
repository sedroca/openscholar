Feature:
  In order to have content at a single URL as a visitor i want to be redirected
  to a canonical URL.

  @api @last
  Scenario: Non-aliased node paths redirect on sites without domains.
    Given I should be redirected in the following <cases>:
   #  | Request                                 | Code  | Final URL                     |
      | john                                    | 200   | john                          |
      | node/1                                  | 302   | edison                        |

  @api @wip
  Scenario: Non-aliased node paths redirect on sites with domains.
    Given I should be redirected in the following <cases>:
    # |   Prefix  | Title                   | Path? | Code  | Expected URL                        |
      |           | John Fitzgerald Kennedy | No    | 302   | john/people/john-fitzgerald-kennedy |
      | john/     | John Fitzgerald Kennedy | No    | 302   | john/people/john-fitzgerald-kennedy |
      | john/     | John Fitzgerald Kennedy | Yes   | 200   | john/people/john-fitzgerald-kennedy |

  @api @wip
  Scenario Outline: Non-aliased system paths redirect on sites with domains.
    Given I am on a site with a custom domain "custom.com"
     When I visit <request-url>
     Then I should get a <code> HTTP response
      And I should be on <final-url>

    Examples:
      | request-url     | code | final-url |
      | "john"          | 301  | ""        |
      | "john/news"     | 301  | "news"    |

  @api @last
  Scenario: Verifying redirect of sites with a share domain.
    Given I visit "http://lincoln.local/john/blog/first-blog"
     Then I should be on "john/blog/first-blog"

  @api @last
  Scenario: Verifying redirect of sites without a share domain.
    Given I login as "admin" in "Abraham"
      And I set the Share domain name to "0"
     When I visit "http://lincoln.local/john/blog/first-blog"
     Then I should be on "john/blog/first-blog"

  @api
  Scenario: Redirecting when watching Biblio on the wrong vsite.
    Given I am logging in as "john"
     When I visit "john/biblio/2"
     Then I should get a 200 HTTP response
      And I should be on "john/biblio/2
     When I visit "obama/biblio/2"
     Then I should get a 302 HTTP response
      And I should be on "john/biblio/2
