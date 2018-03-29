class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      # flast shows on first redirect
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else      # validations failed 
      # render the new template
      render 'new'    
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end