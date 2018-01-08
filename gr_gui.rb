Shoes.app do
    background white
        stack(margin: 20) {
          @test = button "A bed of clams"
        }
        @test.click {
            reaper = %x{ls}
        }
end