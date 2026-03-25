posts_data = [
  {
    title: "How I set up my weekly planning ritual in Strety",
    body: "I've been using Strety for about six months now and finally landed on a workflow that clicks. Every Monday morning I review my strategic goals, check progress on key results, and flag anything that's gone off track. The trick is keeping it under 20 minutes — if your weekly check-in feels like a chore, you're tracking too much. Start with 3-5 goals max and expand from there. Curious how others structure their weekly rhythm?"
  },
  {
    title: "Quick tip: use tags to filter your dashboard",
    body: "Just discovered you can tag goals by team or initiative and then filter your dashboard down to just what matters for a given meeting. Game changer for cross-functional syncs — instead of scrolling through everything, I just filter by the relevant tag and share my screen. No more 'let me find that goal real quick' moments. Small feature, huge time saver."
  },
  {
    title: "Question: how do you handle goals that span multiple quarters?",
    body: "We have a few strategic initiatives that are definitely longer than a single quarter. Right now I'm duplicating them each quarter and linking back to the original, but it feels clunky. Has anyone found a cleaner way to handle multi-quarter goals in Strety? Would love to hear how other teams think about this. Maybe there's something obvious I'm missing."
  },
  {
    title: "Our team went from zero visibility to full alignment in 3 weeks",
    body: "Before Strety, our leadership team had goals scattered across spreadsheets, docs, and slides that nobody looked at after the offsite. We committed to putting everything in Strety and doing a 15-minute async check-in each week. Three weeks in, people started referencing each other's goals in meetings unprompted. That's when I knew it was working — alignment isn't a document, it's a habit."
  },
  {
    title: "Ideas for making check-ins less painful?",
    body: "I love Strety but I'll be honest — getting my team to actually do their weekly check-ins is like pulling teeth. Anyone have creative ways to make updates feel less like homework? I've thought about tying it to our Monday standup or making it a 5-minute block at the start of our team meeting. What's worked for your teams? Bonus points if it doesn't involve bribing people with snacks."
  }
]

posts_data.each do |data|
  Post.find_or_create_by!(title: data[:title]) do |post|
    post.body = data[:body]
  end
end

Bookmark.destroy_all

bookmarked_titles = [
  "Ideas for making check-ins less painful?",
  "Our team went from zero visibility to full alignment in 3 weeks",
  "How I set up my weekly planning ritual in Strety"
]

bookmarked_titles.each do |title|
  post = Post.find_by!(title: title)
  post.bookmarks.create!(name: post.title)
end

puts "Seeded #{Post.count} posts and #{Bookmark.count} bookmark(s)."
