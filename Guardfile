guard 'sass', input: 'sass', output: 'public/css'
guard 'coffeescript', input: 'coffee', output: "public/js"
guard 'livereload' do
  watch(%r{(views|texts)/.+.(erb|haml|slim|md|markdown|txtl)})
  watch(%r{public/css/.+.css})
  watch(%r{public/js/.+.js})
end