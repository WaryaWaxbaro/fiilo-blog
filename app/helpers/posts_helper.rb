module PostsHelper
  def get_random_img
    img_files = ['html_5.jpeg', 'comp_walpaper.jpeg', 'excel.jpeg', 'js-book.jpeg', 'keyboard.jpeg']
    random = rand(5)
    puts "random #{img_files[random]}"
    img_files[random]
  end
end
