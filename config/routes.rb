KifuCommetter::Application.routes.draw do
  resources :forms
  resources :comments

  get('kifu_documents/toggle_form' => 'kifu_documents#toggle_form_visible',
      :as => :toggle_form_visible)

  get 'forms_autocomplete(?query=:query)' =>
    'forms#autocomplete', :as => :forms_autocomplete

  get 'documents' => 'documents#readme', :as => :documents
  get 'documents/ReadMe.html' => 'documents#readme', :as => :documents_readme
  get 'documents/PoliciesAndThanks.html' => 'documents#policies_and_thanks', :as => :documents_policies_and_thanks
  get 'documents/GettingStarted.html' => 'documents#getting_started', :as => :documents_getting_started
  get 'documents/BugReport.html' => 'documents#bug_report', :as => :documents_bug_report
  get 'documents/ToDo.html' => 'documents#todo', :as => :documents_todo

  get 'kifu_documents/:id/merge' => 'kifu_documents#merge', :as => :merge_form_kifu_document
  post 'kifu_documents/:id/merge' => 'kifu_documents#merge', :as => :merge_kifu_document
  get 'kifu_documents/download/:id.kif' => 'kifu_documents#send_kifu', :as => :download_kifu_document
  get 'kifu_documents/download/:id.orig.kif' => 'kifu_documents#send_original_kifu', :as => :download_original_kifu_document
  get 'kifu_documents/:id/editu' => 'kifu_documents#edit_with_upload', :as => :editu_kifu_document
  put 'kifu_documents/:id/editu' => 'kifu_documents#edit_with_upload', :as => :editu_kifu_document
  get 'kifu_documents/:id.kif' => 'kifu_documents#kif', :as => :kifu_document_kif
  get 'kifu_documents/:id.kifu' => 'kifu_documents#kifu', :as => :kifu_document_kifu
  get  'kifu_documents/newp' => 'kifu_documents#new_with_plain_kifu', :as => :newp_kifu_document
  post 'kifu_documents/newp' => 'kifu_documents#new_with_plain_kifu', :as => :newp_kifu_document
  resources :kifu_documents

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "kifu_documents#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
