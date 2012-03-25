require 'spec_helper'

describe MoviesController do
  describe 'edit movie info' do
    it 'should select edit template for rendering'
    it 'should make the movie attributes available to that template for editing'
  end
  describe 'update movie info' do
    it 'should call update_attributes! method'
    it 'should notice about updating the movie'
    it 'should redirect to the movie page'
  end
  describe 'show movie info' do
    it 'should select show template for rendering'
    it 'should make the movie attributes available to that template'
  end
  describe 'add new movie' do
    it 'should select add template for rendering' do
      get :new
    end
  end
  describe 'create new movie' do
    before(:each) do
      @movie = {"title"=>"s", "rating"=>"G", "release_date(1i)"=>"2012", "release_date(2i)"=>"3", "release_date(3i)"=>"25"}
      @m = mock('movie')
    end
    it 'should call create! method' do
      Movie.should_receive(:create!).with(@movie).and_return(@m)
      @m.stub(:title)
      post :create, {:movie => @movie} 
    end
    describe 'after create!' do
      before(:each) do
        Movie.stub(:create!).with(@movie).and_return(@m)
        @m.stub(:title => 'Alien')
        post :create, {:movie => @movie}
      end
      it 'should notice about creating the movie' do
        @controller.instance_eval{flash.stub!(:sweep)}
        get :index
        flash.now[:notice].should be == "Alien was successfully created."
      end
      it 'should redirect to the movie page' do
        response.should redirect_to(:movies)
      end  
    end
  end
  describe 'destroy the movie' do
    it 'should call destroy method'
    it 'should notice about destroying the movie'
    it 'should redirect to the movies list'
  end
  describe 'index' do
    it 'should call find_all_by_rating method'
    it 'should select index template for rendering'
    it 'should make the movies list available to that template for editing'
  end
      
  describe 'Update Movie Info2' do
    # before(:each) do
      # post :create, {:title => 'Alien', :rating => 'R', :release_date => '1979-05-25'}
    # end
    # it 'should call update method' do
      # @movie = Movie.find(1)
      # put :update, {:id => 1, :movie => {:title => 'Alien', :rating => 'R', :release_date => '1979-05-25', :director => 'Mike'}}
      # @movie.should_receive(:update).with(anything())
      # response.should redirect_to(:controller => 'movies', :action => 'show')
      # get :index
      # post :create
      # get :new
      # get :edit, {:id => 1}
      # debugger
      # p Movie.find_by_title('Alien')
      # id = Movie.find_by_title('Alien')[:id]
      # get :show, {:id => id}
    # end
  end
end