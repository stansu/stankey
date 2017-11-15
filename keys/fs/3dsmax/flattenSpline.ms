$.pos.z = 0

for i = $ do

(

        if (classof i == LinkCompositeshape) or (classof i == LinkComposite) do convertToSplineShape i

        if superclassof i == shape do

        (

                new_z = i.pos.z

                for s = 1 to (numSplines i) do

                (

                        for k = 1 to (numKnots i s) do

                        (

                                knt = getKnotPoint i s k

                                in_vec = getInVec i s k

                                out_vec = getOutVec i s k

                                knt.z = in_vec.z = out_vec.z = new_z

                                setInVec i s k in_vec

                                setOutVec i s k out_vec

                                setKnotPoint i s k knt

                        )

                )

                updateshape i

        )

)
