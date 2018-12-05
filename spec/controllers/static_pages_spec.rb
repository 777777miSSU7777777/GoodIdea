require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
    describe "#static_pages" do
        
        after :all do
            Rails.cache.clear
        end

        it 'Returns index page -> success' do
            get "index"
            expect(response).to render_template("index")  
        end

        it 'Returns contacts page -> success' do
            get 'contacts'
            expect(response).to render_template("contacts")
        end

        it 'Returns about page -> success' do
            get 'about'
            expect(response).to render_template("about")
        end
    end
end
