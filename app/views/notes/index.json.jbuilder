json.array!(@notes) do |note|
  json.extract! note, :id, :title, :markdown
  json.url note_url(note, format: :json)
end
