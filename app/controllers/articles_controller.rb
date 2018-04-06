class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show,:destroy]
  
  def index
    @articleList = Article.all
  end

  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = User.first              # temporary !!
    if @article.save
      # flast shows on first redirect
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else      # validations failed 
      # render the new template
      render 'new'    
    end
  end
  
  def update
    
    if @article.update(article_params)
      flash[:success] = "Article successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article successfully deleted"
    redirect_to articles_path
  end
  
  private
    def find_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end