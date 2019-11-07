class Api::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  def avatar
    article = Article.find_by(id: params[:id])
  
    if article&.avatar&.attached?
      redirect_to rails_blob_url(article.avatar)
    else
      head :not_found
    end
  end

  # GET /articles/1
  def show
    article = Article.find_by(id: params[:id])
  
    if article.present?
      render json: success_json(article), status: :ok
    else
      head :not_found
    end
  end

  # POST /articles
  def create
    article = Article.new(create_params)

    if article.save
      render json: success_json(article), status: :created
    else
      render json: error_json(article), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def create_params
      params.require(:article).permit(:title, :avatar)
    end

    def success_json(article)
      {
        article: {
          id: article.id,
          title: article.title
        }
      }
    end
  
    def error_json(article)
      { errors: article.errors.full_messages }
    end

    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title)
    end
end
