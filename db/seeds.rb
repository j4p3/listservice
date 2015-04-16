seeds_path = File.expand_path('..', __FILE__)
$LOAD_PATH << seeds_path unless $LOAD_PATH.include?(seeds_path)

load 'seed_posts.rb'