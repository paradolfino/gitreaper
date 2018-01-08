Shoes.app do
    background white
        stack(margin: 20) {
          @test = button "A bed of clams"
          button "A coalition of cheetahs"
          button "A gulp of swallows"
        }
        @test.click {
            reaper = %x{"ls"}
            alert reaper
        }
end