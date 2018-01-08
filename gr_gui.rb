Shoes.app do
    background white
        stack(margin: 20) {
          @test = button "A bed of clams"
          @out = para "Test"
        }
        @test.click {
            reaper = %x{ls}
            @out.replace "Test"
        }
end