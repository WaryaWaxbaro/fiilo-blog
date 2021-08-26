module PostsHelper
  def get_random_img
    img_files = ['html_5.jpg', 'comp_walpaper.jpg', 'excel.jpg', 'js-book.jpg', 'keyboard.jpg',
                 'books_puzzle.jpg', 'cubes.jpg', 'glass_ball.jpg', 'glassball_with_keyboard.jpg',
                 'screen_with_code.jpg', 'shadow_screen.jpg', 'shiney_keyboard.jpg']
    random = rand(12)
    img_files[random]
  end
end
