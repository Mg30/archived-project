<?php

namespace CP\CocolocBundle\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use CP\CocolocBundle\Entity\commentaire;
use CP\CocolocBundle\Entity\Annonce;
use CP\CocolocBundle\Form\AnnonceType;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use CP\UserBundle\Entity\User;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;


/**
*@Route ("/auth/{_locale}")
*/

class AnnonceController extends Controller{


	/**
	* @Route("/user/delete/{id}", requirements={"id":"\d+"},name="deleteAnnonce")
	*/

	public function deleteAction(Annonce $annonce, Request $request){
		$em = $this->getDoctrine()->getManager();
		$em->remove($annonce);
		$em->flush();
		$userManager= $this->get('fos_user.user_manager');
		$user = $userManager->findUsers();

		return $this->redirectToRoute('myAnnonce');
	}


	/**
	* @Route("/user/add", name="addAnnonce")
	* @return Symfony\Component\HttpFoundation\Response
	* @throws \LogicException
	*/

	public function newAction (Request $request){
		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
        $breadcrumbs->addItem("Ajouter une annonce");
		$annonce = new Annonce();
		$user = $this->getUser();
		$form = $this->createForm(AnnonceType::class, $annonce,[
    		'action'=>$this->generateUrl('addAnnonce')
    	]);
    	$form->handleRequest($request);
    	if (!$form->isSubmitted() || ! $form->isValid()){

  			return $this->render('@CPCocoloc/Annonce/new.html.twig',[
  				'form'=> $form->createView(),

  			]);
  		}
  		$annonce->setUser($user);
  		$annonce->setnbdispo($annonce->getNbplace());
  		$em = $this->getDoctrine()->getManager();
  		$em->persist($annonce);
  		$em->flush();

  		$this->addFlash('notice', 'Annonce postée');

        return $this->redirectToRoute('index');

	}

	/**
	* @Route ("/user/edit/{id}", requirements ={"id": "\d+"}, name= "editAnnonce")
	*/

	public function updateAction(Annonce $annonce, Request $request){
		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Mon compte",$this->get("router")->generate("Myaccount"));
        $breadcrumbs->addItem("Mes annonces",$this->get("router")->generate("myAnnonce"));
        $breadcrumbs->addItem("Editer une annonce");;

		$form = $this->createForm(AnnonceType::class, $annonce);
		$form->handleRequest($request);
		if (!$form->isSubmitted() || ! $form->isValid()){

  			return $this->render('@CPCocoloc/Annonce/edit.html.twig',[
  				'annonce'=> $annonce,
  				'form'=> $form->createView(),
  			]);
  		}
  		$annonce->setDatepublication(new \Datetime());
  		 $em = $this->getDoctrine()->getManager();
  		$em->flush();
  		$this->addFlash('notice', 'Annonce modfiée');

  		return $this->redirectToRoute('myAnnonce');

	}

		/**
	* @Route("/user/home", name="home")
	* @return Symfony\Component\HttpFoundation\Response
	* @throws \LogicException
	*/

		public function homeAction(Request $request){
		$repository = $this->getDoctrine()->getRepository(Annonce::class);
		$user= $this->getUser();
		$annonce = $repository->findBy(
  								array('user' => $user), 
  								array('datePublication' => 'desc')
  							);

		return $this->render('@CPCocoloc/Annonce/home.html.twig',[
			'Annonce'=> $annonce
		]);
	}



	/**
	* @Route ("/user/clone/{id}", requirements ={"id": "\d+"}, name= "cloneAnnonce")
	*/

	public function cloneAction (Annonce $annonce, Request $request){
		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
        $breadcrumbs->addItem("Ajouter une annonce");
		$newAnnonce = new Annonce();
		$newAnnonce->setTitre($annonce->getTitre());
		$newAnnonce->setPrix($annonce->getPrix());
		$newAnnonce->setDatepublication( $annonce->getDatepublication());
		$newAnnonce->setUser($annonce->getUser());
		$newAnnonce->setContenu($annonce->getContenu());
		$newAnnonce->setCategorie($annonce->getCategorie());
		$newAnnonce->setNbplace( $annonce->getNbplace());
		$newAnnonce->setnbdispo($annonce->getnbdispo());
		$newAnnonce->setImage($annonce->getImage());
		$newAnnonce->setVille($annonce->getVille());
		$newAnnonce->setCommentaire( $annonce->getCommentaires());
  		$em = $this->getDoctrine()->getManager();
  		$em->persist($newAnnonce);
  		$em->flush();

        return $this->redirectToRoute('index');

	}




}
?>