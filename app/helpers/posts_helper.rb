module PostsHelper
  def get_random_img
    img_files = ['html_5.jpeg', 'comp_walpaper.jpeg', 'excel.jpeg', 'js-book.jpeg', 'keyboard.jpeg',
                 'books_puzzle.jpeg', 'cubes.jpeg', 'glass_ball.jpeg', 'glassball_with_keyboard.jpeg',
                 'screen_with_code.jpeg', 'shadow_screen.jpeg', 'shiney_keyboard.jpeg']
    random = rand(12)
    img_files[random]
  end
end
