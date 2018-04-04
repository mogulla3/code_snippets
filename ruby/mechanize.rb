require 'mechanize'
require 'dotenv'

Dotenv.load

m = Mechanize.new

# jump to login page
login_page = m.get("https://darktree.jp/login")

# fill email and password in login form
form = login_page.form
form.email = ENV['EMAIL']
form.password = ENV['PASSWORD']

# jump to top page that lists decks of logged-in user
decks_page = m.submit(form, form.buttons.first)

# fetch deck_name from HTML document
# li.dt-deck > p.card-title > a
decks = decks_page.search("li\.dt-deck")
decks.each do |deck|
  puts deck.css("p.card-title > a").first.text
end