use starknet::ContractAddress;
use array::ArrayTrait;


#[starknet::contract]
mod aditor_image {
    #[storage]
    struct Storage {
        //  imageData: felt [] ;
    }

    #[constructor]
    // fn constructor(ref self: ContractState,image: felt[]) {
    //     self.imageData.write(imageData);
    // }

    fn rotate(imageData: Array<felt252> , degrees:felt252) -> Array<felt252>{
  


        let x= imageData.len();

        let width : felt252 = sqrt(imageData.len().try_into().unwrap());
        let hight : felt252 = width;

        let mut rotatedImage : Array<felt252> = ArrayTrait::new();
        let mut i : felt252 = 0;
        let mut j : felt252 =0 ;
        if(degrees == 90){
            loop {
                if i >= width{
                    break();
                }
                j = 0;
                loop{
                    if j >= hight {
                        break();
                    }
                    let newIndex : felt252 = (j * width) + (width -i - 1);
                    // rotatedImage[newIndex] = imageData[i * hight +j];
                    rotatedImage[newIndex] = imageData[i * hight +j];

                    j = j+1;
                };

                i = i+1;
            }
        }
        else 
            if degrees == 270{
                i=0;
                loop {
                    if i >= width{
                        breake();
                    }
                    j = 0;
                    loop{
                        if j >= height {
                            breake();
                        }
                        let newIndex : felt252 = ((height - j - 1) * width) + i;
                        // rotatedImage[newIndex] = imageData[i * hight +j];
                        rotatedImage.get(newIndex) = imageData.get(i * hight +j);
    
                        j = j+1;
                    }
    
                    i = i+1;
                }
            }
            
            rotatedImage
        }
   
        fn sqrt(num : felt252) -> felt252{
            num ** 0.5;
        }
}
