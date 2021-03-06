#encoding: utf-8
class EntriesController < ApplicationController
  before_filter :authorize!, :except => [:show, :index, :by_id]
  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id]) 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  def by_id
    @entry = Entry.find_by_wadoku_id(params[:wadoku_id]) if params[:wadoku_id]
    redirect_to @entry
  end

  def by_domain
    redirect_to :controller => :search, :action => :index, :search => {:definition_contains => params[:dom]}
  end


  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to(@entry, :notice => 'Entry was successfully created.') }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to(@entry, :notice => 'Entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end

  private

  #placeholder for real authorization
  def authorize!
    flash[:notice] = t("users.not_authorized", :default => "Leider nicht möglich")
    redirect_to :back
  end
end
