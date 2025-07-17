class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder

  # Redirects resources to the collection path (index action) instead
  # of the resource path (show action) for POST/PUT/DELETE requests.
  # include Responders::CollectionResponder

  # def api_behavior
  #   raise MissingRenderer, format unless has_renderer?

  #   answer = resource.try(:to_model) || resource
  #   if get?
  #     display answer
  #   elsif post?
  #     display answer, status: :created
  #   else
  #     display answer
  #   end
  # end

  # Configure default status codes for responding to errors and redirects.
  self.error_status = :unprocessable_entity
  self.redirect_status = :see_other
end
