class Api::NotesController < ApplicationController
  before_action :set_note, only: %i[ show update destroy toggle ]

  # GET /notes
  def index
    params[:isActive] ? noteActive = false : noteActive = true
    if params[:category]  && params[:category] != ""
      @notes = Note.includes(:categories).where(user_id: @current_user.id, isActive: noteActive, categories:{id: params[:category]} )
    else
      @notes = Note.where(user_id: @current_user.id, isActive: noteActive)
    end
    render json: @notes
  end

  # GET /notes/1
  def show
    @categories_all = Category.all.as_json(:except => [:created_at, :updated_at])
    @categories_assigned= @note.categories.as_json(:except => [:created_at, :updated_at])
    @categories = @categories_all - @categories_assigned
    data= {
      note: @note,
      note_categories: @categories_assigned,
      categories: @categories
    }
    render json: data
  end

  # POST /notes
  def create
    @note = Note.new(user_id:@current_user.id, title:params[:note][:title], content:params[:note][:content])
    categories = params[:categories].map { |c| Category.find(c[:id])}
    
    if @note.save
      categories.each { |c| @note.categories << c}
      render json: @note, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH /notes/1/toggle
  def toggle
    @note.toggle(:isActive)
    @note.save
    render json: @note
  end

  # PATCH/PUT /notes/1
  def update
    categories = params[:categories].map { |c| Category.find(c[:id])} if params[:categories]
    note_categories = @note.categories
    categories.each { |c| @note.categories << c unless note_categories.exists?(c.id) }
    @note.categories.each { |c| @note.categories.delete(c) unless categories.include?(c) }

    if @note.update(title:params[:note][:title],content:params[:note][:content])
      @categories_all = Category.all.as_json(:except => [:created_at, :updated_at])
      @categories_assigned= @note.categories.as_json(:except => [:created_at, :updated_at])
      @categories = @categories_all - @categories_assigned
      data= {
        note: @note,
        note_categories: @categories_assigned,
        categories: @categories
      }
      render json: data
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :content, :isActive, {categories=> [:id, :name]})
    end
end
