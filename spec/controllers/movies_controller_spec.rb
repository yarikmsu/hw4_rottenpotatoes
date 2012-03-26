require 'spec_helper'

describe MoviesController do
  describe 'edit movie info' do
    before(:each) do
      @m = mock('movie', :id => '1234', :title => 'Alien')
    end
    it 'should call find method' do
      Movie.should_receive(:find).with('1234').and_return(@m)
      get :edit, :id => 1234
    end
    context 'after find' do
      before(:each) do
        Movie.stub(:find).with('1234').and_return(@m)
        get :edit, :id => 1234
      end
      it 'should select edit template for rendering' do
        response.should render_template('edit')
      end
      it 'should make the movie attributes available to that template for editing' do
        assigns(:movie).should == @m
      end
    end
  end
  describe 'update movie info' do
    before(:each) do
      @movie = {"title"=>"s", "rating"=>"G", "release_date(1i)"=>"2012", "release_date(2i)"=>"3", "release_date(3i)"=>"25"}
      @m = mock('movie', :id => '1234', :title => 'Alien')
    end
    it 'should call find method' do
      Movie.should_receive(:find).with('1234').and_return(@m)
      @m.stub(:update_attributes!)
      put :update, :id => 1234, :movie => @movie
    end
    it 'should call update_attributes! method' do
      Movie.stub(:find).with('1234').and_return(@m)
      @m.should_receive(:update_attributes!).with(@movie)
      put :update, :id => 1234, :movie => @movie
    end
    describe 'after update_attributes!' do
      before(:each) do
        Movie.stub(:find).with('1234').and_return(@m)
        @m.stub(:update_attributes!).with(@movie)
        put :update, :id => 1234, :movie => @movie
      end
      it 'should notice about updating the movie' do
        @controller.instance_eval{flash.stub!(:sweep)}
        flash.now[:notice].should be == "Alien was successfully updated."
      end
      it 'should redirect to the movie page' do
        response.should redirect_to(:action=>'show', :controller=>'movies', :id=>@m)
      end
    end
  end
  describe 'show movie info' do
    before(:each) do
      @m = mock('movie', :id => '1234', :title => 'Alien')
    end
    it 'should call find method' do
      Movie.should_receive(:find).with('1234').and_return(@m)
      get :show, :id => 1234
    end
    context 'after find' do
      before(:each) do
        Movie.stub(:find).with('1234').and_return(@m)
        get :show, :id => 1234
      end
      it 'should select show template for rendering' do
        response.should render_template(:show)
      end
      it 'should make the movie attributes available to that template' do
        assigns(:movie).should == @m
      end
    end
  end
  describe 'add new movie' do
    it 'should select add template for rendering' do
      get :new
      response.should render_template('new')
    end
  end
  describe 'create new movie' do
    before(:each) do
      @movie = {"title"=>"s", "rating"=>"G", "release_date(1i)"=>"2012", "release_date(2i)"=>"3", "release_date(3i)"=>"25"}
      @m = mock('movie', :title => 'Alien')
    end
    it 'should call create! method' do
      Movie.should_receive(:create!).with(@movie).and_return(@m)
      post :create, {:movie => @movie} 
    end
    describe 'after create!' do
      before(:each) do
        Movie.stub(:create!).with(@movie).and_return(@m)
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
    before(:each) do
      @m = mock('movie', :id => '1234', :title => 'Alien')
    end
    it 'should call find method' do
      Movie.should_receive(:find).with('1234').and_return(@m)
      @m.stub(:destroy)
      delete :destroy, :id => 1234
    end
    it 'should call destroy method' do
      Movie.stub(:find).with('1234').and_return(@m)
      @m.should_receive(:destroy)
      delete :destroy, :id => 1234
    end
    context 'after destroy' do
      before(:each) do
        Movie.stub(:find).with('1234').and_return(@m)
        @m.stub(:destroy)
        delete :destroy, :id => 1234
      end
      it 'should notice about destroying the movie' do
        @controller.instance_eval{flash.stub!(:sweep)}
        flash.now[:notice].should be == "Movie 'Alien' deleted."
      end
      it 'should redirect to the movies list' do
        response.should redirect_to(:movies)
      end
    end
  end
  describe 'index' do
    before(:each) do
      @movies = [mock('movie'), mock('movie')]
    end
    it 'should call find_all_by_rating method' do
      Movie.should_receive(:find_all_by_rating).with([],nil).and_return(@movies)
      get :index
    end
    context 'after :find_all_by_rating' do
      before(:each) do
        Movie.stub(:find_all_by_rating).with([],nil).and_return(@movies)
        get :index
      end
      it 'should select index template for rendering' do
        response.should render_template('index')
      end
      it 'should make the movies list available to that template' do
        assigns(:movies).should == @movies
      end
    end
    it 'should redirect to the movies list with sort by title param' do
      get :index, :sort => "title", :ratings => {"G"=>"1"}
      response.should redirect_to(:action => 'index', :sort => 'title', :ratings => {"G"=>"1"})
    end
    it 'should redirect to the movies list with sort by release_date param' do
      get :index, :sort => "release_date", :ratings => {"G"=>"1"}
    response.should redirect_to(:action => 'index', :sort => 'release_date', :ratings => {"G"=>"1"})
    end
    it 'should redirect to the movies list with ratings params' do
      get :index, :ratings => {"G"=>"1"}
      response.should redirect_to(:action => 'index', :ratings => {"G"=>"1"})
    end
  end
end
