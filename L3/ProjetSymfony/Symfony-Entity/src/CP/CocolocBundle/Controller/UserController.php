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
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;




/**
*@Route ("/auth/{_locale}/account")
*/

class UserController extends Controller{


			/**
	* @Route ("/", name="Myaccount")
	* @return Symfony\Component\HttpFoundation\Response
	*/

	public function accountAction(Request $request){
		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
		$breadcrumbs->addItem("Mon compte",$this->get("router")->generate("Myaccount"));
		return $this->render('@CPCocoloc/User/Myaccount.html.twig'
		);

	}


	/**
	* @Route ("/myAnnonce", name="myAnnonce")
	* @return Symfony\Component\HttpFoundation\Response
	*/

	public function myAnnonceAction(Request $request){

		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
		$breadcrumbs->addItem("Mon compte",$this->get("router")->generate("Myaccount"));
        $breadcrumbs->addItem("Mes annonces",$this->get("router")->generate("myAnnonce"));
		$listAnnonce= $this->getUser()->getAnnonce();
		$annonce = $this->get('knp_paginator')->paginate($listAnnonce,
		$request->query->get('page',1),8);
		return $this->render('@CPCocoloc/User/myAnnonce.html.twig',[
			'Annonce'=> $annonce
		]);
	}


		/**
	* @Route ("/theme", name="mytheme")
	* @return Symfony\Component\HttpFoundation\Response
	* @throws \LogicException
	*/

	public function themeAction (Request $request){

		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
		$breadcrumbs->addItem("Mon compte",$this->get("router")->generate("Myaccount"));
        $breadcrumbs->addItem("Themes",$this->get("router")->generate("mytheme"));

		$defaultData = array('theme' => 'default');
    	$form = $this->createFormBuilder($defaultData)
        ->add('theme', ChoiceType::class, array(
        	'choices'=>array(
        		'theme 1' => 'cyborg',
        		'theme 2' => 'flaty',
        		'theme 3' => 'Journal',
        		'theme 4' => 'Darkly',
        		'theme 5' => 'Superhero',
        		'theme 6' => 'bootstrap'
        	)
        ))
        ->add('Ok', SubmitType::class)
        ->getForm();

    	$form->handleRequest($request);

    	if ($form->isSubmitted() && $form->isValid()) {
        
       	 	$data = $form->getData();
        	$data = implode(',' , $data);
        	$this->get('session')->set('theme',$data);
    }

    	return $this->render('@CPCocoloc/User/theme.html.twig', [
		'form'=>$form->createView()

	]);


	}



		/**
	* @Route ("/myReservation", name="myreservation")
	* @return Symfony\Component\HttpFoundation\Response
	*/

	public function myReservationAction(Request $request){

		$breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
		$breadcrumbs->addItem("Mon compte",$this->get("router")->generate("Myaccount"));
        $breadcrumbs->addItem("Mes reservation",$this->get("router")->generate("myAnnonce"));
        $listreserv = $this->getUser()->getReservation();
		$reserv = $this->get('knp_paginator')->paginate($listreserv,
		$request->query->get('page',1),5);
		return $this->render('@CPCocoloc/User/myReservation.html.twig',[
			'reservation'=> $reserv
		]);
	}


	/**
	* @Route ("/profile/{id}",requirements ={"id": "\d+"}, name="profile")
	*/
	
	public function ProfileAction(User $user){

       $breadcrumbs = $this->get("white_october_breadcrumbs");
		$breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
		$breadcrumbs->addItem("Mon compte",$this->get("router")->generate("Myaccount"));
            $breadcrumbs->addItem("Mon profile");

		return $this->render('@CPCocoloc/User/profile.html.twig',[
			'user'=> $user
		]);

	}

}

?>