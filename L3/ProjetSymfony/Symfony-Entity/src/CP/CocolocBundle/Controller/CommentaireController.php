<?php

namespace CP\CocolocBundle\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use CP\CocolocBundle\Entity\commentaire;
use CP\CocolocBundle\Form\commentaireType;
use CP\CocolocBundle\Entity\Annonce;


/**
*@Route ("auth/{_locale}/Comment")
*/

class CommentaireController extends Controller
{


	/**
	* @Route("/add/{id}",name="addComment")
	* @return Symfony\Component\HttpFoundation\Response
	* @throws \LogicException
	*/
    public function newAction(Annonce $annonce, Request $request)
    {

    	$commentaire = new commentaire();
    	$form = $this->createForm(commentaireType::class, $commentaire,[
    		'action'=>$this->generateUrl('addComment', ['id'=>$annonce->getId()])
    	]);
    $user= $this->getUser();

    $commentaire->setAnnonce($annonce);
    $commentaire->setUser($user);

    	$form->handleRequest($request);
    	if (!$form->isSubmitted() || ! $form->isValid()){

  			return $this->render('@CPCocoloc/Commentaires/new.html.twig',[
  				'form'=> $form->createView(),
  				'annonce'=>$annonce,

  			]);
  		}
  		
  		$em = $this->getDoctrine()->getManager();
  		$em->persist($commentaire);
  		$em->flush();

  		$this->addFlash('notice', 'commentaire posté');

        return $this->redirectToRoute('show',['id'=>$annonce->getId()]);
    }



      /**
  * @Route("/delete/{id}", requirements={"id":"\d+"},name="deletecomment")
  */

  public function deleteAction(commentaire $comment, Request $request){
    $em = $this->getDoctrine()->getManager();
    $em->remove($comment);
    $em->flush();
    $userManager= $this->get('fos_user.user_manager');
    $user = $userManager->findUsers();
    $annonce = $comment->getAnnonce();

    return $this->redirectToRoute('show',['id'=>$annonce->getId()]);;
  }


  /**
  * @Route ("/edit/{id}", requirements ={"id": "\d+"}, name= "editcomment")
  */

  public function updateAction(commentaire $comment, Request $request){
    $form = $this->createForm(commentaireType::class, $comment);
    $form->handleRequest($request);
    if (!$form->isSubmitted() || ! $form->isValid()){

        return $this->render('@CPCocoloc/comment/edit.html.twig',[
          'comment'=> $comment,
          'form'=> $form->createView(),
        ]);
      }
      $comment->setDate(new \Datetime());
       $em = $this->getDoctrine()->getManager();
    $annonce = $comment->getAnnonce();

    return $this->redirectToRoute('show',['id'=>$annonce->getId()]);;

  }





}




?>