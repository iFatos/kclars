require './lib/recommendations.rb'
require '././recommend.rb'
class StudentsController < ApplicationController
  # GET /students
  # GET /students.xml
  def index
   @students = Student.where("").order('id').page(params[:page]).per(10)
   #@students = Student.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to(@student, :notice => 'Student was successfully created.') }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
        UserMailer.deliver_registration_confirmation(@student) 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(@student, :notice => 'Student was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
  
  def recr 
    @b = "."
    @array = []
    r = Recommendations.new
    app = App.new
    @h = Hash.new(0)
    @final = Hash.new(0)
    @s = Student.all
    @s.each do |x|
     v = x.votes  
     hash = Hash.new 
     v.each do |p|
      
      hash[p.event_id] = p.vote
      
     end   
     @final[x.name] = hash
    end
   
     @b = r.getRecommendations(@final,"Chirag")
    
  end
  
  def getContentRecommendations
   @student = Student.find(params[:id])
   f = Fatos.new
   @results = f.second(f.first(@student))   
   respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @results }
    end

  end
   
end
