if selection.count != 0 then

(

        tempObj = pickObject message:"select an object's material, then assign to current object."

        if     tempObj != undefined do

        (

                if tempObj.material != undefined then

                (

                        if tempObj != undefined do

                        (

                                if classof tempObj.material == multimaterial do messagebox "source material is Multi-materials!"

                                $.material = tempObj.material

                                if classof tempObj.modifiers[1] == Uvwmap and tempObj.modifiers[1] != selection[1].modifiers[1]do

                                (

                                        ask = querybox "instance UVW_modifier too?"

                                        if ask do

                                        (

                                                modPanel.addModToSelection (tempObj.modifiers[1]) ui:on

                                        )

                                )

                                try

                                (

                                        $.realWorldMapSize = tempObj.realWorldMapSize

                                )catch()

                                try

                                (

                                        $.realWorldMapSize = tempObj.modifiers[1].realWorldMapSize

                                )catch()

                                try

                                (

                                        $.modifiers[1].realWorldMapSize = tempObj.realWorldMapSize

                                )catch()

                                try

                                (

                                        $.modifiers[1].realWorldMapSize = tempObj.modifiers[1].realWorldMapSize

                                )catch()

                                clearListener()

                        )

                )

                else

                (

                        if querybox "Target haven't material! assign wire color?" do

                        (

                                $.wirecolor = tempObj.wirecolor

                        )

                )

        )

)

else messageBox "Please select object for assign material!"
