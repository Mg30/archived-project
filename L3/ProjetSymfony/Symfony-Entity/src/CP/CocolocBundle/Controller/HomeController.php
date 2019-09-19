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
use CP\CocolocBundle\Form\AnnonceSearchType;
use Symfony\Component\HttpFoundation\Cookie;
use Suin\RSSWriter\Feed;
use Suin\RSSWriter\Channel;
use Suin\RSSWriter\Item;


/**
*@Route ("/{_locale}/home")
*/


class HomeController extends Controller{



		/**
	* @Route ("/show/{id}",requirements ={"id": "\d+"}, name="show")
	*/

	public function showAction(Annonce $annonce){

        $breadcrumbs = $this->get("white_october_breadcrumbs");
        $breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
        $breadcrumbs->addItem("Index",$this->get("router")->generate("index"));
            $breadcrumbs->addItem("Annonce");

		return $this->render('@CPCocoloc/Home/show.html.twig',[
			'Annonce'=> $annonce
		]);

	}


		/**
	* @Route("/index", name="index")
	* @return Symfony\Component\HttpFoundation\Response
	* @throws \LogicException
	*/

	public function indexAction(Request $request){
		$repository = $this->getDoctrine()->getRepository(Annonce::class);
		$listAnnonce = $repository->findAll(array('datePublication' => 'desc'));
		$annonce = $this->get('knp_paginator')->paginate($listAnnonce,
		$request->query->get('page',1),4);
        $breadcrumbs = $this->get("white_october_breadcrumbs");
        $breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
        $breadcrumbs->addItem("Index",$this->get("router")->generate("index"));
		return $this->render('@CPCocoloc/Home/index.html.twig',[
			'Annonce'=> $annonce
		]);
	}


			/**
	* @Route ("/", name="accueil")
	* @return Symfony\Component\HttpFoundation\Response
	*/

	public function homeAction(Request $request){
		$theme = 'bootstrap';

        if ($this->get('session')->get('theme') == null ){
            $this->get('session')->set('theme',$theme);
        }

        $breadcrumbs = $this->get("white_october_breadcrumbs");
        $breadcrumbs->addItem("Home",$this->get("router")->generate("accueil"));
        $ville =$request->query->get('prix_max');
    	$cat =  $request->query->get('place_max');
    	if ( $ville == null && $cat == null ){

		return $this->render('@CPCocoloc/Home/Acceuil.html.twig');
	}

	}

	    /**
     * @Route("/rss.xml", name="annonce_rss")
     */
    public function rssAction(Request $request)
    {
        $domaine = 'http://Cocoloc.fr/';
        $repository = $this->getDoctrine()->getRepository(Annonce::class);
        $annonce = $repository->findAll();
        $locale =  $request->getLocale();
        $feed = new Feed();
        $channel = new Channel();
        $channel
            ->title('Annonce')
            ->description('Liste des annonce de colocation')
            ->url('http://Cocoloc.fr')
            ->feedUrl('http://Cocoloc.fr/rss')
            ->copyright('Copyright 2018, Cocoloc')
            ->pubDate(strtotime(date('Y-m-d H:i:s')))
            ->lastBuildDate(strtotime(date('Y-m-d H:i:s')))
            ->appendTo($feed);
        foreach ($annonce as $a) {
            $item = new Item();
            $item
                ->title($a->getTitre())
                ->description('<div>'.$a->getContenu().'</div>')
                ->url($domaine.$locale.'/event/'.$a->getId())
                ->pubDate($a->getDatepublication()->getTimeStamp())
                ->appendTo($channel);
        }
        $response = new Response($feed);
        $response->headers->set('Content-Type', 'xml');
        return $response;
    }


 }

?>