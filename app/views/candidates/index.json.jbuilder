json.array!(@candidates) do |candidate|
  json.extract! candidate, :id, :name, :email, :cover_letter
  json.url job_posting_candidate_url(candidate, format: :json)
end
